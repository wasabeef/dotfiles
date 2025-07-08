#!/bin/bash

# エラー記録スクリプト
# PostToolUse で発生したエラーを YAML 形式で記録

ERROR_LOG_FILE="$HOME/.claude/knowledge/errors.yaml"
KNOWLEDGE_DIR="$HOME/.claude/knowledge"

# ディレクトリが存在しない場合は作成
mkdir -p "$KNOWLEDGE_DIR"

# YAML ファイルが存在しない場合は初期化
if [[ ! -f "$ERROR_LOG_FILE" ]]; then
    cat > "$ERROR_LOG_FILE" << 'EOF'
# Claude Code エラーナレッジベース
# 発生したエラーとその解決策を記録

errors:
EOF
fi

# 標準入力から JSON を読み取り
INPUT=$(cat)

# デバッグ用ログ
echo "[DEBUG] $(date): $INPUT" >> /tmp/error-recorder-debug.log

# PostToolUse でツールがエラーを返した場合
if echo "$INPUT" | jq -e '.hook_event_name == "PostToolUse"' > /dev/null 2>&1; then
    # hook データから直接エラーを抽出
    ERROR_MSG=""
    TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // "unknown"')
    COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // .tool_input.pattern // .tool_input.file_path // "unknown"')
    
    # tool_response.stderr からエラーを検索
    if echo "$INPUT" | jq -e '.tool_response.stderr != null and .tool_response.stderr != ""' > /dev/null 2>&1; then
        ERROR_MSG=$(echo "$INPUT" | jq -r '.tool_response.stderr')
    fi
    
    if [[ -n "$ERROR_MSG" && "$ERROR_MSG" != "null" ]]; then
        TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%S+09:00")
        
        # エラーカテゴリを推定
        CATEGORY="unknown_error"
        if echo "$ERROR_MSG" | grep -q "command not found"; then
            CATEGORY="command_not_found"
        elif echo "$ERROR_MSG" | grep -q "No such file or directory"; then
            CATEGORY="file_not_found"
        elif echo "$ERROR_MSG" | grep -q "Permission denied"; then
            CATEGORY="permission_denied"
        elif echo "$ERROR_MSG" | grep -q "error parsing flag"; then
            CATEGORY="command_flag_error"
        elif echo "$ERROR_MSG" | grep -q "syntax error\|parse error"; then
            CATEGORY="syntax_error"
        fi
        
        # 解決策とプリベンション策を提案
        SOLUTION="Review command documentation and fix syntax"
        PREVENTION="Validate command before execution"
        
        case "$CATEGORY" in
            "command_flag_error")
                SOLUTION="Check command documentation and use correct flags"
                PREVENTION="Verify command syntax before execution"
                ;;
            "command_not_found")
                SOLUTION="Install the required command or use alternative"
                PREVENTION="Check if command is available before use"
                ;;
            "file_not_found")
                SOLUTION="Verify file path exists or create the file"
                PREVENTION="Use file existence checks before operations"
                ;;
            "permission_denied")
                SOLUTION="Check file permissions or run with appropriate privileges"
                PREVENTION="Verify write permissions before file operations"
                ;;
            "syntax_error")
                SOLUTION="Fix syntax according to tool documentation"
                PREVENTION="Validate syntax before execution"
                ;;
        esac
        
        # 重複チェック（同じエラーが既に記録されているか）
        if ! grep -Fq "error: \"$ERROR_MSG\"" "$ERROR_LOG_FILE"; then
            # YAML エントリを追加
            cat >> "$ERROR_LOG_FILE" << EOF

  - timestamp: "$TIMESTAMP"
    tool: "$TOOL_NAME"
    command: "$COMMAND"
    error: "$ERROR_MSG"
    category: "$CATEGORY"
    solution: "$SOLUTION"
    prevention: "$PREVENTION"
EOF
            
            echo "Error recorded: $CATEGORY - $ERROR_MSG" >&2
        fi
    fi
fi

# 元の JSON をそのまま出力（パイプラインを壊さない）
echo "$INPUT"