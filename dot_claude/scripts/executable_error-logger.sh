#!/bin/bash

# エラーログをナレッジベースに追記するスクリプト

ERROR_LOG="$HOME/.claude/error-knowledge.yml"
TOOL_NAME=$(echo "$CLAUDE_TOOL_INPUT" | jq -r '.tool_name // "Unknown"')
COMMAND=$(echo "$CLAUDE_TOOL_INPUT" | jq -r '.tool_input.command // ""')
ERROR_OUTPUT=$(cat)
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
PROJECT_DIR=$(pwd)

# エラーログファイルがなければ作成
if [ ! -f "$ERROR_LOG" ]; then
    cat > "$ERROR_LOG" << 'EOF'
# Claude Code エラーナレッジベース
# 過去のエラーと解決方法を蓄積し、同じエラーを回避するために利用

errors: []
EOF
fi

# yq を使ってYAMLに安全に追記
yq eval ".errors += [{
  \"timestamp\": \"$TIMESTAMP\",
  \"type\": \"runtime_error\", 
  \"tool\": \"$TOOL_NAME\",
  \"command\": \"$COMMAND\",
  \"project\": \"$PROJECT_DIR\",
  \"error\": \"$ERROR_OUTPUT\",
  \"solution\": null
}]" -i "$ERROR_LOG"

echo "❌ エラーをナレッジベースに記録しました: $ERROR_LOG"