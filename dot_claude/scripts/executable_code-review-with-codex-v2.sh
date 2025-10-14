#!/bin/bash

# Codex を使用して Git diff のコードレビューを行うスクリプト (Devin MCP 統合版)
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

# /clear や /compact コマンドの場合はスキップ
if echo "$DIFF_CONTENT" | grep -qE '^\+.*(^|[^a-zA-Z0-9])(/clear|/compact)([^a-zA-Z0-9]|$)'; then
  echo "Skipping code review for /clear or /compact command" >&2
  exit 0
fi

# Codex 利用可能性確認
if ! command -v codex >/dev/null 2>&1; then
  echo "Error: codex command not found" >&2
  exit 1
fi

# API Keys の取得（~/.env から読み込み、環境変数でオーバーライド可能）
if [ -f "$HOME/.env" ]; then
  # ~/.env から DEVIN_API_KEY を読み込む（export や引用符を処理）
  DEVIN_API_KEY=$(grep '^DEVIN_API_KEY=' "$HOME/.env" | cut -d '=' -f2- | sed -e 's/^"//' -e 's/"$//' -e "s/^'//" -e "s/'$//")
fi

# 環境変数が設定されている場合は、それを優先
DEVIN_API_KEY="${DEVIN_API_KEY:-}"

# MCP 統合状況を報告
if [ -n "$DEVIN_API_KEY" ]; then
  echo "Info: Devin MCP enabled (private repo support)" >&2
else
  echo "Warning: DEVIN_API_KEY not found, Devin MCP unavailable" >&2
fi

# DeepWiki は常に利用可能（パブリックリポジトリのドキュメント用）
echo "Info: DeepWiki MCP enabled (public repo documentation)" >&2

if [ -z "$DEVIN_API_KEY" ]; then
  echo "Info: Running with DeepWiki MCP only (public documentation)" >&2
fi

# コードレビュープロンプトの作成
# 注: codex exec は自動的に AGENTS.md を読み込むため、手動での読み込みは不要
prompt="あなたは経験豊富なソフトウェアエンジニアとしてコードレビューを行います。

## コンテキスト取得プロトコル

1. **一次情報の優先確認**
   - 提供された diff、変更対象ファイルの前後文脈、既存テスト、ローカルの AGENTS.md/docs/README などリポジトリ内ドキュメントを最優先で確認してください。

2. **型定義や実装の確認には MCP を積極利用**
   - 未知の型・クラス・メソッド・プロパティが出現した場合、まず MCP で確認してください。
   - 利用可能な MCP サーバーを確認し、devin (プライベート向け) と deepwiki (公開向け) を使い分けます。
   - 特に以下の場合は MCP による確認を推奨：
     * プロジェクト固有の型やクラス
     * フレームワーク固有の実装やビジネスロジック

3. **MCP での情報収集（型・実装確認時は必須）**
   - **未知の型が現れたら必ず実行**:
     * ask_question で「この型の定義を教えてください」
     * ask_question で「このプロパティは存在しますか？」
   - **ドキュメント確認手順**:
     * read_wiki_structure: 関連しそうなトピックを確認
     * read_wiki_contents: 該当ドキュメントを取得し、ローカル資料と突き合わせ
     * ask_question: 具体的な疑問を投げて補完情報を得る
   - Devin から情報が得られない場合のみ DeepWiki で公開情報を補完してください。

4. **情報源の記録**
   - MCP から得た内容を判断根拠に使った場合は、(Devin: auth.md)、(DeepWiki: README.md) のようにファイル名のみで出典を findings/comment に必ず記載してください。
   - 情報取得に失敗した場合は findings に「情報不足」と明記し、confidence_score ≤ 0.5 としてください。

## 重要な前提条件

- diff・既存コード・テスト・AGENTS.md を最優先で検証し、MCP は補助的に利用してください。
- 標準ライブラリに存在しない型・メソッド・プロパティが現れた場合は、積極的に MCP で確認してください。
- 裏付けが取れない指摘は confidence_score ≤ 0.7。Devin/DeepWiki で根拠を取得できた場合のみ 0.8 以上を付けてください。
- プロジェクト固有の拡張は、型定義やドキュメントで確認してから評価してください。
- 取得できなかった情報が判断に影響する場合は findings に明記してください。

以下の git diff を詳細にレビューし、Google・Microsoft のコードレビューガイドラインに基づいて各評価項目を採点してください。
各項目 0-12.5 点満点で、総合スコアは 8 項目の合計（100 点満点）です。

## 評価項目と採点基準

1. **機能性 (functionality)** - 12.5 点満点
   - 12.5 点: 要求を完全に満たし、バグなし、エッジケースにも対応
   - 8 点: 基本機能は動作、軽微な問題あり
   - 4 点: 部分的に動作、重要な問題あり
   - 0 点: 動作しない、重大なバグ

2. **コード品質 (code_quality)** - 12.5 点満点
   - 12.5 点: 高い可読性・保守性、適切な抽象化、DRY 原則遵守
   - 8 点: 概ね良好、軽微な改善点あり
   - 4 点: 理解困難、重複コードあり
   - 0 点: 非常に悪い品質、保守困難

3. **設計 (design)** - 12.5 点満点
   - 12.5 点: アーキテクチャに完全適合、適切な設計パターン使用
   - 8 点: 概ね適切、軽微な設計上の問題
   - 4 点: 設計に懸念、将来の拡張性に問題
   - 0 点: 設計が破綻、全体構造に悪影響

4. **テスト (testing)** - 12.5 点満点
   - 12.5 点: 十分なカバレッジと質の高いテスト（テスト不要な変更でも満点可）
   - 8 点: 基本的なテストあり、カバレッジ不足
   - 4 点: 最小限のテスト、品質に問題
   - 0 点: 必要なテストが欠如

5. **セキュリティ (security)** - 12.5 点満点
   - 12.5 点: セキュリティ問題なし、ベストプラクティス遵守
   - 8 点: 軽微な改善点あり
   - 4 点: 中程度のリスク存在
   - 0 点: 深刻な脆弱性

6. **パフォーマンス (performance)** - 12.5 点満点
   - 12.5 点: 実行効率・メモリ使用が最適
   - 8 点: 概ね良好、軽微な最適化余地
   - 4 点: 性能上の懸念あり
   - 0 点: 深刻な性能問題

7. **命名とコメント (naming_comments)** - 12.5 点満点
   - 12.5 点: 意図が明確な命名、適切なコメント/ドキュメント
   - 8 点: 概ね良好、改善余地あり
   - 4 点: 不明瞭な命名、コメント不足
   - 0 点: 非常に悪い命名、コメントなし

8. **コーディング規約 (coding_standards)** - 12.5 点満点
   - 12.5 点: スタイルガイド完全遵守、一貫性あり
   - 8 点: 概ね遵守、軽微な違反
   - 4 点: 多くの違反
   - 0 点: 規約無視、一貫性なし

## 優先度レベル

- **P0**: ブロッキング問題、即修正
- **P1**: 緊急、次サイクルで対応
- **P2**: 通常優先度
- **P3**: 低優先度、改善推奨

JSON 出力は厳密に以下の形式で返してください：

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
  \"devin_insights\": {
    \"security_issues\": \"Devin で得た知見。利用しなかった場合は \\\"N/A\\\"\",
    \"performance_insights\": \"Devin で得た知見。利用しなかった場合は \\\"N/A\\\"\",
    \"best_practices\": \"Devin で得た知見。利用しなかった場合は \\\"N/A\\\"\"
  },
  \"findings\": [
    {
      \"title\": \"問題の簡潔な説明\",
      \"body\": \"問題の詳細説明\",
      \"confidence_score\": 確信度（0.0-1.0 の数値）,
      \"priority\": 優先度（0-3 の整数、P0=0, P1=1, P2=2, P3=3）,
      \"source\": \"検出ソース（\\\"codex\\\" / \\\"Devin\\\" / \\\"DeepWiki\\\"）\",
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

- JSON の各項目は必ず対応する数値・文字列型を守ってください。
- comment と各 finding には、利用した情報源（例: (AGENTS.md: セクション3)、(Devin: docs/auth.md)、(DeepWiki: README)）を括弧書きで明記してください。
- findings は最大 5 件まで。情報不足の場合はその旨を記し、confidence_score ≤ 0.5。
- Devin が利用できない場合でも、ローカル情報に基づくレビューを完遂してください。"

# 現在のディレクトリのフルパスを取得
project_path=$(pwd)

# JSON ファイルに保存
score_file="$HOME/.claude/code_review_scores.json"

# 一時ファイルで codex の出力を取得し、バックグラウンドで処理完了後に JSON 保存
temp_file=$(mktemp)
(
  # MCP 統合設定を構築
  # DeepWiki MCP は常に有効（config.toml で設定済みと仮定）
  # Devin MCP は API Key がある場合のみ追加
  if [ -n "$DEVIN_API_KEY" ]; then
    # Devin と DeepWiki の両方が利用可能な場合
    # codex exec オプション:
    # --model: 使用するモデル（config.toml のデフォルトを使用するため省略可能）
    # --sandbox read-only: 読み取り専用サンドボックス（レビューなので書き込み不要）
    # --color never: バックグラウンド実行なのでカラー出力不要
    # --json: 構造化された出力を確実に取得
    # --output-last-message: 最終メッセージ（JSON 結果）を保存
    # -c: MCP サーバー設定（Devin と DeepWiki の両方）
    echo "$prompt" | timeout 300 codex exec \
      --sandbox read-only \
      --skip-git-repo-check \
      --color never \
      --json \
      --output-last-message "$temp_file" \
      -c 'mcp_servers.devin.command="npx"' \
      -c 'mcp_servers.devin.args=["-y","mcp-remote","https://mcp.devin.ai/sse","--header","Authorization:${DEVIN_AUTH}"]' \
      -c "mcp_servers.devin.env={ DEVIN_AUTH = \"Bearer $DEVIN_API_KEY\" }" \
      -c 'mcp_servers.deepwiki.command="npx"' \
      -c 'mcp_servers.deepwiki.args=["-y","@himanoa-mcp/deepwiki"]' \
      >/dev/null 2>&1
  else
    # DeepWiki MCP のみ利用可能な場合
    echo "$prompt" | timeout 300 codex exec \
      --sandbox read-only \
      --skip-git-repo-check \
      --color never \
      --json \
      --output-last-message "$temp_file" \
      -c 'mcp_servers.deepwiki.command="npx"' \
      -c 'mcp_servers.deepwiki.args=["-y","@himanoa-mcp/deepwiki"]' \
      >/dev/null 2>&1
  fi

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

    # Devin MCP の結果も抽出（存在する場合）
    devin_insights=$(echo "$evaluation" | jq '.devin_insights // {}')

    # プロジェクトのレビューデータを作成
    project_data=$(
      cat <<EOF
{
  "score": $score,
  "max_score": 100,
  "evaluation_method": "codex",
  "devin_enabled": $([ -n "$DEVIN_API_KEY" ] && echo "true" || echo "false"),
  "details": {
    "functionality": $functionality,
    "code_quality": $code_quality,
    "design": $design,
    "testing": $testing,
    "security": $security,
    "performance": $performance,
    "naming_comments": $naming_comments,
    "coding_standards": $standards,
    "comment": "$comment",
    "devin_insights": $devin_insights
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
if [ -n "$DEVIN_API_KEY" ]; then
  echo "Code review with Codex and Devin MCP started in background" >&2
else
  echo "Code review with Codex started in background (Devin MCP not available)" >&2
fi
exit 0
