#!/bin/bash

# 標準入力から JSON を読み込む
json_input=$(cat)

# jq が利用可能かチェック
if ! command -v jq >/dev/null 2>&1; then
  # jq がない場合は何もしない
  exit 0
fi

# JSON からプロンプトとセッション情報を抽出
prompt=$(echo "$json_input" | jq -r '.prompt // empty')
cwd=$(echo "$json_input" | jq -r '.cwd // empty')
session_id=$(echo "$json_input" | jq -r '.session_id // empty')

# プロンプトが空でない場合のみ評価
if [ -n "$prompt" ]; then
  # バックグラウンドで評価を実行（UI をブロックしない）
  {
    # 作業ディレクトリがある場合は移動
    if [ -n "$cwd" ]; then
      cd "$cwd" || exit 1
    fi

    # プロンプトとセッション ID を評価スクリプトに渡す
    ~/.claude/scripts/evaluate-prompt-with-codex.sh "$prompt" "$session_id" 2>/dev/null
  } &
fi

# 何も出力しない（JSON 応答は不要）
exit 0
