#!/bin/bash

# プロジェクト固有のプランファイルが存在するかチェック
check_project_plan() {
  local current_project_dir="$(pwd)"
  echo "DEBUG: Current directory: $current_project_dir" >&2
  
  # パスの正規化: .claude -> --claude のような特殊ケースを処理
  local normalized_project_dir="$(echo "$current_project_dir" | sed 's/^\//-/; s/\/\./--/g; s/\//-/g')"
  echo "DEBUG: Normalized directory: $normalized_project_dir" >&2
  
  local project_sessions_dir="$HOME/.claude/projects/$normalized_project_dir"
  echo "DEBUG: Project sessions directory: $project_sessions_dir" >&2
  
  local todos_dir="$HOME/.claude/todos"
  echo "DEBUG: Todos directory: $todos_dir" >&2
  
  # プロジェクトディレクトリが存在するかチェック
  if [ ! -d "$project_sessions_dir" ]; then
    echo "DEBUG: Project sessions directory does not exist" >&2
    return 1
  fi
  
  # 最新のセッションファイルを取得（更新時間順）
  local latest_session=$(stat -f '%m %N' "$project_sessions_dir"/*.jsonl 2>/dev/null | sort -nr | head -1 | cut -d' ' -f2-)
  echo "DEBUG: Latest session file: $latest_session" >&2
  
  if [ -z "$latest_session" ]; then
    echo "DEBUG: No session file found" >&2
    return 1
  fi
  
  # セッション ID を取得（ファイル内を検索して最新の sessionId を見つける）
  local session_id=$(grep -h '"sessionId"' "$latest_session" 2>/dev/null | tail -1 | jq -r .sessionId 2>/dev/null)
  echo "DEBUG: Session ID: $session_id" >&2
  
  if [ -z "$session_id" ] || [ "$session_id" = "null" ]; then
    echo "DEBUG: No valid session ID found" >&2
    return 1
  fi
  
  # そのセッション ID に対応するプランファイルが存在するかチェック
  local plan_file="$todos_dir/$session_id.json"
  echo "DEBUG: Looking for plan file: $plan_file" >&2
  
  if [ -f "$plan_file" ]; then
    echo "DEBUG: Plan file exists!" >&2
    return 0  # プランファイルが存在
  else
    echo "DEBUG: Plan file does not exist" >&2
    return 1  # プランファイルが存在しない
  fi
}

# メイン処理
if check_project_plan; then
  echo '{"continue": false, "stopReason": "💡 /show-plan でプランを確認"}'
fi