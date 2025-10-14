#!/bin/bash

# Session 初期化フック
# セッション開始時に code_review_scores.json から現在のディレクトリのレコードを削除

# 標準入力を読み捨て（Hook の仕様上必要）
cat >/dev/null

# code_review_scores.json から現在のディレクトリのレコードを削除
scores_file="$HOME/.claude/code_review_scores.json"
current_dir="$(pwd)"

if [ -f "$scores_file" ]; then
  # 現在のディレクトリのレコードを削除
  temp_scores=$(mktemp)

  # 正常に処理できた場合のみ上書き
  if jq --arg dir "$current_dir" 'del(.[$dir])' "$scores_file" >"$temp_scores" 2>/dev/null && [ -s "$temp_scores" ]; then
    mv "$temp_scores" "$scores_file"
  else
    rm -f "$temp_scores"
  fi
fi

# 何も返さない
echo "{}"

exit 0
