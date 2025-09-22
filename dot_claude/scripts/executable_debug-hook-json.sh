#!/bin/bash

# 標準入力から JSON を読み込む
json_input=$(cat)

# デバッグ用：受け取った JSON を保存
timestamp=$(date +%Y%m%d_%H%M%S)
debug_file="$HOME/.claude/debug/hook_json_${timestamp}.json"

# デバッグディレクトリを作成
mkdir -p "$HOME/.claude/debug"

# JSON を整形して保存
echo "$json_input" | jq '.' > "$debug_file" 2>/dev/null || echo "$json_input" > "$debug_file"

# JSON の主要なキーを抽出して別ファイルに保存
if command -v jq >/dev/null 2>&1; then
  echo "=== Hook JSON Structure ===" > "${debug_file}.analysis"
  echo "Keys:" >> "${debug_file}.analysis"
  echo "$json_input" | jq -r 'keys[]' >> "${debug_file}.analysis" 2>/dev/null

  echo "" >> "${debug_file}.analysis"
  echo "=== Full JSON ===" >> "${debug_file}.analysis"
  echo "$json_input" | jq '.' >> "${debug_file}.analysis" 2>/dev/null
fi

# 何も出力しない（hook の動作を妨げない）
exit 0