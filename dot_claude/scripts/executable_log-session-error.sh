#!/bin/bash

# セッション中のエラーを一時記録

SESSION_ERRORS="/tmp/claude-session-errors-$(date +%Y%m%d-%H%M%S).log"
ERROR_TEXT="$1"

if [ -z "$ERROR_TEXT" ]; then
    # パイプからエラーを読み取り
    ERROR_TEXT=$(cat)
fi

if [ -n "$ERROR_TEXT" ]; then
    echo "$(date '+%H:%M:%S'): $ERROR_TEXT" >> "$SESSION_ERRORS"
    echo "❌ セッションエラーログに記録しました"
else
    echo "エラーテキストが空です"
fi