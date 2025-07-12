#!/bin/bash
set -euo pipefail

# 日本語と半角英数字の間に半角スペースを挿入

# ファイルパス取得 （ 引数または JSON 入力 ）
if [ -n "${1:-}" ]; then
  file_path="$1"
else
  if [ -n "${CLAUDE_TOOL_INPUT:-}" ]; then
    input_json="$CLAUDE_TOOL_INPUT"
  else
    input_json=$(cat)
  fi
  file_path=$(echo "$input_json" | jq -r '.tool_input.file_path // empty')
fi

# 基本チェック
[ -z "$file_path" ] && exit 0
[ ! -f "$file_path" ] && exit 0
[ ! -r "$file_path" ] && exit 0
[ ! -w "$file_path" ] && exit 0

# 日本語文字と英数字の境界にスペース挿入
sed -i '' -E \
  -e 's/([ぁ-ゟァ-ヿ一-鿿㐀-䶿])([a-zA-Z0-9])/\1 \2/g' \
  -e 's/([a-zA-Z0-9])([ぁ-ゟァ-ヿ一-鿿㐀-䶿])/\1 \2/g' \
  -e 's/([ぁ-ゟァ-ヿ一-鿿㐀-䶿])(\()/\1 \2/g' \
  -e 's/(\))([ぁ-ゟァ-ヿ一-鿿㐀-䶿])/\1 \2/g' \
  -e 's/(\))([a-zA-Z0-9])/\1 \2/g' \
  -e 's/(%)([ぁ-ゟァ-ヿ一-鿿㐀-䶿])/\1 \2/g' \
  -e 's/([（(\[{][^）)\]}]*[）)\]}])\s+(の|と|で|が|を|は|に)/\1\2/g' \
  "$file_path"