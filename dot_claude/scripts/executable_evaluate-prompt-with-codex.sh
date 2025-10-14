#!/bin/bash

# Codex を使用してプロンプトを評価するスクリプト（v2）
# 過去のプロンプトを前提状況として活用する改良版

# 引数チェック
if [ -z "$1" ]; then
  echo "Error: No prompt provided" >&2
  exit 1
fi

# プロンプトとセッション ID を取得
prompt="$1"
session_id="${2:-}" # セッション ID（オプション）

# /clear や /compact コマンドの場合はスキップ
if echo "$prompt" | grep -qE '(^|[^a-zA-Z0-9])(/clear|/compact)([^a-zA-Z0-9]|$)'; then
  echo "Skipping prompt evaluation for /clear or /compact command" >&2
  exit 0
fi

# 現在のディレクトリのフルパスを取得（プロジェクトキーとして使用）
project_path=$(pwd)

# JSON ファイルのパス
score_file="$HOME/.claude/prompt_scores.json"

# セッション ID が提供されていない場合は時間ベースで判定
if [ -z "$session_id" ]; then
  # 60 分のタイムアウト
  SESSION_TIMEOUT=3600
  current_time=$(date +%s)

  if [ -f "$score_file" ] && command -v jq >/dev/null 2>&1; then
    last_session=$(jq -r --arg proj "$project_path" '
      .[$proj].current_session_id // ""
    ' "$score_file" 2>/dev/null || echo "")

    last_timestamp=$(jq -r --arg proj "$project_path" '
      .[$proj].timestamp // "1970-01-01T00:00:00Z"
    ' "$score_file" 2>/dev/null || echo "1970-01-01T00:00:00Z")

    # Unix タイムスタンプに変換（macOS 対応）
    if [[ "$OSTYPE" == "darwin"* ]]; then
      last_time=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "$last_timestamp" "+%s" 2>/dev/null || echo 0)
    else
      last_time=$(date -d "$last_timestamp" "+%s" 2>/dev/null || echo 0)
    fi

    # タイムアウトチェック
    if [ $((current_time - last_time)) -gt $SESSION_TIMEOUT ]; then
      # 新セッション
      session_id="session_$(date +%s)"
    else
      # 既存セッションを継続
      session_id="$last_session"
    fi
  else
    # 新規セッション
    session_id="session_$(date +%s)"
  fi
fi

# 同じセッションの過去のプロンプト履歴を取得（最新 10 件）
recent_prompts=""
if [ -f "$score_file" ] && command -v jq >/dev/null 2>&1; then
  current_session=$(jq -r --arg proj "$project_path" '
    .[$proj].current_session_id // ""
  ' "$score_file" 2>/dev/null || echo "")

  # 同じセッションの場合のみ履歴を取得
  if [ "$current_session" = "$session_id" ]; then
    recent_prompts=$(jq -r --arg proj "$project_path" --arg sid "$session_id" '
      if .[$proj].history then
        .[$proj].history |
        map(select(.session_id == $sid)) |
        .[-10:] |
        map(.prompt) |
        join("\n\n--- 過去のプロンプト ---\n")
      else
        ""
      end
    ' "$score_file" 2>/dev/null || echo "")
  fi
fi

# 評価用のプロンプトを作成（v2: 過去のプロンプトを前提として強調）
evaluation_prompt="以下のプロンプトを評価してください。

## 重要な評価方針

**過去のプロンプトは「既に共有された前提・文脈」として扱ってください。**
つまり、過去のプロンプトで言及された内容は：
- すでに AI と共有済みの背景情報
- 今回のプロンプトの暗黙の前提
- 追加で説明不要な既知の文脈

として評価に反映させてください。

$([ -n "$recent_prompts" ] && echo "## 同一セッション内の過去のプロンプト履歴（前提として扱う）：

${recent_prompts}

--- 今回のプロンプト ---")

## 評価対象プロンプト：
\"${prompt}\"

## 評価基準（0-100 点）

以下の観点で採点してください。**ただし、過去のプロンプトで既に提供された情報は「コンテキスト」として加点対象とします**：

1. **明確性と具体性 (clarity)** - 30 点満点
   - 今回のプロンプト単体での明確さ
   - 曖昧さがなく、明確な指示があるか
   - 期待する出力や目的が明確か

2. **コンテキスト提供 (context)** - 25 点満点
   - **過去のプロンプトで提供された背景も含めて評価**
   - 必要な背景情報が（過去または今回で）提供されているか
   - 前提条件や現状が明確か
   - 成功基準が示されているか

3. **構造化 (structure)** - 20 点満点
   - 論理的な構成になっているか
   - 段階的な指示がある場合、適切に分割されているか
   - 過去の文脈を踏まえた論理的な流れか

4. **制約条件の明確化 (constraints)** - 15 点満点
   - 出力の長さ、形式、スタイルなどが指定されているか
   - してはいけないことが明確か
   - 過去の指示との整合性があるか

5. **具体例の提供 (examples)** - 10 点満点
   - 必要に応じて例が含まれているか
   - 過去のプロンプトの例も考慮
   - 期待する出力の例が示されているか

## 評価時の重要な注意点

- **過去のプロンプトがある場合**：それらは「すでに AI が知っている前提」として扱う
- **単発のプロンプトの場合**：通常通り、単体での完成度を評価
- **継続的な会話の一部**：前の文脈があることを前提に、追加指示として妥当か評価

**回答は必ず以下の JSON 形式でのみ返してください：**
{
  \"score\": 総合点（0-100）,
  \"clarity\": 明確性の点数（0-30）,
  \"context\": コンテキストの点数（0-25）,
  \"structure\": 構造の点数（0-20）,
  \"constraints\": 制約の点数（0-15）,
  \"examples\": 例の点数（0-10）,
  \"comment\": \"日本語で改善点の簡潔な説明（1 文）\"
}"

# プロンプトの全文を保存（改行を \n にエスケープ）
prompt_full=$(echo "$prompt" | sed 's/\\/\\\\/g' | sed 's/"/\\"/g' | awk '{printf "%s\\n", $0}' | sed '$ s/\\n$//')

# 一時ファイルで codex の出力を取得し、バックグラウンドで処理完了後に JSON 保存
temp_file=$(mktemp)
(
  # codex exec オプション:
  # --model: 使用するモデル（config.toml のデフォルトを使用するため省略可能）
  # --sandbox read-only: 読み取り専用サンドボックス（評価なので書き込み不要）
  # --color never: バックグラウンド実行なのでカラー出力不要
  # --json: 構造化された出力を確実に取得
  # --output-last-message: 最終メッセージ（JSON 結果）を保存
  echo "$evaluation_prompt" | timeout 300 codex exec \
    --sandbox read-only \
    --skip-git-repo-check \
    --color never \
    --json \
    --output-last-message "$temp_file" \
    >/dev/null 2>&1

  if [ -f "$temp_file" ] && [ -s "$temp_file" ]; then
    evaluation=$(cat "$temp_file")

    # JSON から各スコアを抽出
    score=$(echo "$evaluation" | jq -r '.score // 0')
    clarity=$(echo "$evaluation" | jq -r '.clarity // 0')
    context=$(echo "$evaluation" | jq -r '.context // 0')
    structure=$(echo "$evaluation" | jq -r '.structure // 0')
    examples=$(echo "$evaluation" | jq -r '.examples // 0')
    constraints=$(echo "$evaluation" | jq -r '.constraints // 0')
    comment=$(echo "$evaluation" | jq -r '.comment // "No comment"')

    # 現在のタイムスタンプ
    timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)

    # プロジェクトのプロンプトデータを作成（最新の評価）
    project_data=$(
      cat <<EOF
{
  "score": $score,
  "max_score": 100,
  "prompt_full": "$prompt_full",
  "evaluation_method": "codex",
  "current_session_id": "$session_id",
  "details": {
    "score": $score,
    "clarity": $clarity,
    "context": $context,
    "structure": $structure,
    "examples": $examples,
    "constraints": $constraints,
    "comment": "$comment"
  },
  "timestamp": "$timestamp",
  "project_path": "$project_path"
}
EOF
    )

    # 履歴エントリを作成（セッション ID 付き）
    history_entry=$(
      cat <<EOF
{
  "prompt": "$prompt_full",
  "score": $score,
  "timestamp": "$timestamp",
  "session_id": "$session_id"
}
EOF
    )

    # jq を使用してプロジェクトごとに保存（履歴も含む）
    if command -v jq >/dev/null 2>&1; then
      if [ -f "$score_file" ]; then
        # 既存ファイルがある場合：履歴を更新
        jq --argjson new "$project_data" \
          --argjson hist "$history_entry" \
          --arg proj "$project_path" '
          # 履歴配列を初期化または更新（最大 10 件保持）
          .[$proj].history = ((.[$proj].history // []) + [$hist])[-10:] |
          # 最新のデータで上書き
          .[$proj] = .[$proj] + $new
        ' "$score_file" >"${score_file}.tmp" && mv "${score_file}.tmp" "$score_file"
      else
        # 新規ファイルの場合：履歴付きで作成
        echo "$project_data" | jq --argjson hist "$history_entry" \
          --arg proj "$project_path" '
          {
            ($proj): . + {
              "history": [$hist]
            }
          }
        ' >"$score_file"
      fi
    else
      # jq がない場合は個別ファイルとして保存（履歴なし）
      safe_filename=$(echo "$project_path" | sed 's/\//_/g')
      individual_score_file="$HOME/.claude/prompt_score_${safe_filename}.json"
      echo "$project_data" >"$individual_score_file"
    fi
  fi

  rm -f "$temp_file"
) &

# バックグラウンドで実行するため、即座に終了
echo "Prompt evaluation with Codex v2 (context-aware) started in background" >&2
exit 0

