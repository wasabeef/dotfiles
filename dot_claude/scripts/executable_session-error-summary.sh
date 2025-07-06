#!/bin/bash

# セッション終了時にエラーサマリーを記録

SESSION_ERRORS_PATTERN="/tmp/claude-session-errors-*.log"
ERROR_LOG="$HOME/.claude/error-knowledge.yml"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# セッション中のエラーがあるかチェック
ERROR_FILES=($(ls $SESSION_ERRORS_PATTERN 2>/dev/null))

if [ ${#ERROR_FILES[@]} -gt 0 ]; then
    # 全エラーファイルの内容を結合
    ALL_ERRORS=$(cat "${ERROR_FILES[@]}" 2>/dev/null)
    ERROR_COUNT=$(echo "$ALL_ERRORS" | wc -l)
    
    if [ "$ERROR_COUNT" -gt 0 ] && [ -n "$ALL_ERRORS" ]; then
        # yq を使ってエラーサマリーを安全に追記
        yq eval ".errors += [{
          \"timestamp\": \"$TIMESTAMP\",
          \"type\": \"session_summary\",
          \"count\": $ERROR_COUNT,
          \"errors\": \"$ALL_ERRORS\",
          \"solution\": null
        }]" -i "$ERROR_LOG"
        echo "📝 セッションで ${ERROR_COUNT} 件のエラーを記録しました"
    else
        echo "✅ このセッションではエラーは発生しませんでした"
    fi
    
    # 一時ファイルを削除
    rm -f "${ERROR_FILES[@]}"
else
    echo "ℹ️ エラートラッキング情報がありません"
fi