#!/bin/bash

# Codex を使用して Git diff のコードレビューを行うスクリプト
# hook モード専用 - JSON にスコアを保存


# Git リポジトリでない場合はスキップ
if ! git rev-parse --git-dir >/dev/null 2>&1; then
  exit 0
fi

# git diff を取得（ステージされた変更と作業ディレクトリの変更の両方）
DIFF_CONTENT=$(git diff HEAD 2>/dev/null)

# 差分がない場合はスキップ
if [ -z "$DIFF_CONTENT" ]; then
  exit 0
fi

# Codex 利用可能性確認
if ! command -v codex >/dev/null 2>&1; then
  echo "Error: codex command not found" >&2
  exit 1
fi

# コードレビュープロンプトの作成
# 注: codex exec は自動的に AGENTS.md を読み込むため、手動での読み込みは不要
prompt="あなたは経験豊富なソフトウェアエンジニアとしてコードレビューを行います。

## 重要な前提条件：
- AGENTS.md に記載されているプロジェクト固有の実装を考慮してレビューしてください
- 標準ライブラリに存在しないプロパティやメソッドがある場合、プロジェクト固有の実装の可能性を考慮してください
- 確信が持てない指摘については confidence_score を 0.7 以下に設定してください

以下の git diff を詳細にレビューし、Google・Microsoft のコードレビューガイドラインに基づいて各評価項目を採点してください。
各項目 0-12.5 点満点で、総合スコアは 8 項目の合計（100 点満点）です。

## 評価項目と採点基準：

1. **機能性 (functionality)** - 12.5 点満点
   - 12.5 点：要求を完全に満たし、バグなし、エッジケース対応
   - 8 点：基本機能は動作、軽微な問題あり
   - 4 点：部分的に動作、重要な問題あり
   - 0 点：動作しない、重大なバグ

2. **コード品質 (code_quality)** - 12.5 点満点
   - 12.5 点：高い可読性・保守性、適切な抽象化、DRY 原則遵守
   - 8 点：概ね良好、軽微な改善点あり
   - 4 点：理解困難、重複コードあり
   - 0 点：非常に悪い品質、保守困難

3. **設計 (design)** - 12.5 点満点
   - 12.5 点：アーキテクチャに完全適合、適切な設計パターン使用
   - 8 点：概ね適切、軽微な設計上の問題
   - 4 点：設計に問題、将来の拡張性に懸念
   - 0 点：設計が破綻、全体構造に悪影響

4. **テスト (testing)** - 12.5 点満点
   - 12.5 点：十分なカバレッジ、質の高いテスト（不要な場合は満点）
   - 8 点：基本的なテストあり、カバレッジ不足
   - 4 点：最小限のテスト、品質に問題
   - 0 点：テストなし（必要な場合）

5. **セキュリティ (security)** - 12.5 点満点
   - 12.5 点：セキュリティ問題なし、ベストプラクティス遵守
   - 8 点：軽微なセキュリティ上の改善点
   - 4 点：中程度のセキュリティリスク
   - 0 点：深刻なセキュリティ脆弱性

6. **パフォーマンス (performance)** - 12.5 点満点
   - 12.5 点：最適な実行効率、メモリ使用量
   - 8 点：概ね良好、軽微な最適化の余地
   - 4 点：パフォーマンス問題あり
   - 0 点：深刻なパフォーマンス問題

7. **命名とコメント (naming_comments)** - 12.5 点満点
   - 12.5 点：意図が明確な命名、適切なコメント・ドキュメント
   - 8 点：概ね良好、改善の余地あり
   - 4 点：不明瞭な命名、コメント不足
   - 0 点：非常に悪い命名、コメントなし

8. **コーディング規約 (coding_standards)** - 12.5 点満点
   - 12.5 点：スタイルガイド完全遵守、一貫性あり
   - 8 点：概ね遵守、軽微な違反
   - 4 点：多くのスタイル違反
   - 0 点：規約無視、一貫性なし

## 優先度レベル：
- **P0**: ブロッキング問題、即座に修正必須
- **P1**: 緊急、次のサイクルで対応
- **P2**: 通常優先度
- **P3**: 低優先度、改善推奨

**JSON 出力は厳密に以下の形式で返してください：**
{
  \"score\": 総合点（0-100 の数値）,
  \"functionality\": 機能性の点数（0-12.5 の数値）,
  \"code_quality\": コード品質の点数（0-12.5 の数値）,
  \"design\": 設計の点数（0-12.5 の数値）,
  \"testing\": テストの点数（0-12.5 の数値）,
  \"security\": セキュリティの点数（0-12.5 の数値）,
  \"performance\": パフォーマンスの点数（0-12.5 の数値）,
  \"naming_comments\": 命名とコメントの点数（0-12.5 の数値）,
  \"coding_standards\": コーディング規約の点数（0-12.5 の数値）,
  \"comment\": \"日本語で主な改善点や良い点の簡潔な説明（1-2 文の文字列）\",
  \"findings\": [
    {
      \"title\": \"問題の簡潔な説明\",
      \"body\": \"問題の詳細説明\",
      \"confidence_score\": 確信度（0.0-1.0 の数値）,
      \"priority\": 優先度（0-3 の整数、P0=0, P1=1, P2=2, P3=3）,
      \"code_location\": {
        \"file_path\": \"ファイルパス\",
        \"line_range\": {\"start\": 開始行番号, \"end\": 終了行番号}
      }
    }
  ]
}

---

**レビュー対象の git diff:**

\`\`\`diff
$DIFF_CONTENT
\`\`\`

**重要：**
- JSON の各項目は必ず数値で回答してください
- comment は文字列として、改善点を具体的に簡潔に記載してください
- findings 配列には具体的な問題点を最大 5 個まで記載してください
- confidence_score は問題の確信度を 0.0（低）から 1.0（高）で評価してください
  - プロジェクト固有の実装の可能性がある場合は 0.7 以下に設定
  - 標準ライブラリと異なる動作の可能性がある場合も低めに設定
- 採点は上記の基準に厳密に従ってください
- 存在しないプロパティやメソッドを指摘する前に、プロジェクト固有の定義を考慮してください"

# 現在のディレクトリのフルパスを取得
project_path=$(pwd)

# JSON ファイルに保存
score_file="$HOME/.claude/code_review_scores.json"

# 一時ファイルで codex の出力を取得し、バックグラウンドで処理完了後に JSON 保存
temp_file=$(mktemp)
(
  # codex exec オプション:
  # --model: 使用するモデル（config.toml のデフォルトを使用するため省略可能）
  # --sandbox read-only: 読み取り専用サンドボックス（レビューなので書き込み不要）
  # --color never: バックグラウンド実行なのでカラー出力不要
  # --json: 構造化された出力を確実に取得
  # --output-last-message: 最終メッセージ（JSON 結果）を保存
  # --skip-git-repo-check: Git リポジトリ外でも実行可能に（不要な場合は削除）
  echo "$prompt" | timeout 300 codex exec \
    --sandbox read-only \
    --color never \
    --json \
    --output-last-message "$temp_file" \
    - >/dev/null 2>&1

  if [ -f "$temp_file" ] && [ -s "$temp_file" ]; then
    evaluation=$(cat "$temp_file")

    # JSON から各スコアを抽出
    score=$(echo "$evaluation" | jq -r '.score // 0')
    functionality=$(echo "$evaluation" | jq -r '.functionality // 0')
    code_quality=$(echo "$evaluation" | jq -r '.code_quality // 0')
    design=$(echo "$evaluation" | jq -r '.design // 0')
    testing=$(echo "$evaluation" | jq -r '.testing // 0')
    security=$(echo "$evaluation" | jq -r '.security // 0')
    performance=$(echo "$evaluation" | jq -r '.performance // 0')
    naming_comments=$(echo "$evaluation" | jq -r '.naming_comments // 0')
    standards=$(echo "$evaluation" | jq -r '.coding_standards // 0')
    comment=$(echo "$evaluation" | jq -r '.comment // "コメントなし"')

    # プロジェクトのレビューデータを作成
    project_data=$(cat <<EOF
{
  "score": $score,
  "max_score": 100,
  "evaluation_method": "codex",
  "details": {
    "functionality": $functionality,
    "code_quality": $code_quality,
    "design": $design,
    "testing": $testing,
    "security": $security,
    "performance": $performance,
    "naming_comments": $naming_comments,
    "coding_standards": $standards,
    "comment": "$comment"
  },
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "project_path": "$project_path"
}
EOF
)

    # jq を使用してプロジェクトごとに保存
    if command -v jq >/dev/null 2>&1; then
      if [ -f "$score_file" ]; then
        jq --argjson new "$project_data" --arg proj "$project_path" '.[$proj] = $new' "$score_file" >"${score_file}.tmp" && mv "${score_file}.tmp" "$score_file"
      else
        echo "$project_data" | jq --arg proj "$project_path" '{($proj): .}' >"$score_file"
      fi
    else
      # jq がない場合は個別ファイルとして保存
      safe_filename=$(echo "$project_path" | sed 's/\//_/g')
      individual_score_file="$HOME/.claude/code_review_score${safe_filename}.json"
      echo "$project_data" >"$individual_score_file"
    fi
  fi

  rm -f "$temp_file"
) &

# バックグラウンドで実行するため、即座に終了
echo "Code review with Codex started in background" >&2
exit 0
