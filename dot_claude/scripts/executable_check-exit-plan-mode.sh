#!/bin/bash

# exit_plan_mode で作成されたプランが存在するかチェック
check_exit_plan_mode() {
  local current_project_dir="$(pwd)"
  # パスの正規化: .claude -> --claude のような特殊ケースを処理
  local normalized_project_dir="$(echo "$current_project_dir" | sed 's/^\//-/; s/\/\./--/g; s/\//-/g')"
  local project_sessions_dir="$HOME/.claude/projects/$normalized_project_dir"
  
  # プロジェクトディレクトリが存在するかチェック
  if [ ! -d "$project_sessions_dir" ]; then
    return 1
  fi
  
  # 最新のセッションファイルを取得（更新時間順）
  local latest_session=$(stat -f '%m %N' "$project_sessions_dir"/*.jsonl 2>/dev/null | sort -nr | head -1 | cut -d' ' -f2-)
  if [ -z "$latest_session" ]; then
    return 1
  fi
  
  # exit_plan_mode のプランを探す
  local plan=$(grep "exit_plan_mode" "$latest_session" 2>/dev/null | \
    jq -r 'select(.message.content[]? | select(.type == "tool_use" and .name == "exit_plan_mode")) | .message.content[] | select(.type == "tool_use" and .name == "exit_plan_mode") | .input.plan' 2>/dev/null | \
    head -1)
  
  if [ -n "$plan" ] && [ "$plan" != "null" ]; then
    return 0  # プランが存在
  else
    return 1  # プランが存在しない
  fi
}

# メイン処理
if check_exit_plan_mode; then
  echo '{"continue": false, "stopReason": "💡 /show-plan でプランを確認"}'
fi