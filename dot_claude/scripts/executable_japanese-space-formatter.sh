#!/bin/bash
set -euo pipefail

# 日本語と半角英数字の間に半角スペースを挿入するスクリプト
# Claude Code の PostToolUse hook から呼び出される

# 一時ファイルの確実な削除
cleanup() {
    if [ -n "${tmp_file:-}" ] && [ -f "$tmp_file" ]; then
        rm "$tmp_file"
    fi
}
trap cleanup EXIT

# jq の存在チェック
if ! command -v jq >/dev/null 2>&1; then
    echo "Error: jq is required but not installed" >&2
    exit 1
fi

# 引数からファイルパスを取得、なければ標準入力から JSON を読み取る
if [ -n "${1:-}" ]; then
    file_path="$1"
else
    # 標準入力から JSON を読み取ってファイルパスを取得
    # CLAUDE_TOOL_INPUT が設定されている場合はそれを使用
    if [ -n "${CLAUDE_TOOL_INPUT:-}" ]; then
        input_json="$CLAUDE_TOOL_INPUT"
    else
        input_json=$(cat)
    fi
    file_path=$(echo "$input_json" | jq -r '.tool_input.file_path // empty')
fi

# 入力値検証
if [ -z "$file_path" ]; then
    exit 0
fi

# パストラバーサル攻撃対策
if [[ "$file_path" =~ \.\. ]]; then
    echo "Error: Invalid file path containing '..'" >&2
    exit 1
fi

# ファイルが存在しない場合は終了
if [ ! -f "$file_path" ]; then
    exit 0
fi

# 日本語と半角英数字の間にスペースを挿入
# 1. 日本語文字 + 半角英数字 → 日本語文字 + スペース + 半角英数字
# 2. 半角英数字 + 日本語文字 → 半角英数字 + スペース + 日本語文字

# 一時ファイルを作成
tmp_file=$(mktemp)

# sed を使って変換
sed -E \
    -e 's/([ぁ-ゟ])([a-zA-Z0-9])/\1 \2/g' \
    -e 's/([ァ-ヿ])([a-zA-Z0-9])/\1 \2/g' \
    -e 's/([一-龯])([a-zA-Z0-9])/\1 \2/g' \
    -e 's/([a-zA-Z0-9])([ぁ-ゟ])/\1 \2/g' \
    -e 's/([a-zA-Z0-9])([ァ-ヿ])/\1 \2/g' \
    -e 's/([a-zA-Z0-9])([一-龯])/\1 \2/g' \
    "$file_path" > "$tmp_file"

# 変更があった場合のみファイルを更新
if ! cmp -s "$file_path" "$tmp_file"; then
    mv "$tmp_file" "$file_path"
    echo "日本語スペースフォーマット適用: $file_path" >&2
    # mv で移動したので cleanup で削除する tmp_file を無効化
    tmp_file=""
fi