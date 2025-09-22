#!/usr/bin/env bash

# Constants
readonly CLAUDE_TOKEN_FILE="$HOME/.claude/claude_token.txt"
readonly MAX_CONTEXT=200000 # Maximum context tokens

# Get today's cost from a cached file
get_cached_cost() {
  local cache_file="$HOME/.claude/.cache_daily_cost"

  if [ -f "$cache_file" ]; then
    local cost
    cost=$(cat "$cache_file")
    echo "$cost"
  else
    echo "0.00"
  fi
}

# Update cost cache file
update_cost_cache() {
  local cost="$1"
  local cache_file="$HOME/.claude/.cache_daily_cost"
  echo "$cost" >"$cache_file"
}

# Reset daily cost at midnight
reset_daily_cost() {
  local current_date
  current_date=$(date +%Y-%m-%d)

  local cache_date_file="$HOME/.claude/.cache_date"

  # Check if date file exists and compare
  if [ -f "$cache_date_file" ]; then
    local cached_date
    cached_date=$(cat "$cache_date_file")

    if [ "$current_date" != "$cached_date" ]; then
      # Reset cost for new day
      update_cost_cache "0.00"
      echo "$current_date" >"$cache_date_file"
    fi
  else
    # Initialize date file
    echo "$current_date" >"$cache_date_file"
    update_cost_cache "0.00"
  fi
}

# Calculate cost from CLAUDE_TOKEN data
calculate_cost_from_file() {
  if [ ! -f "$CLAUDE_TOKEN_FILE" ]; then
    echo "0.00"
    return
  fi

  local total_cost=0

  # Read costs from file and sum them
  while IFS= read -r line; do
    # Extract cost value (format: $X.XX)
    local cost
    cost=$(echo "$line" | grep -oE '\$[0-9]+\.[0-9]+' | tr -d '$')
    if [ -n "$cost" ]; then
      total_cost=$(echo "scale=2; $total_cost + $cost" | bc -l 2>/dev/null || echo "0.00")
    fi
  done <"$CLAUDE_TOKEN_FILE"

  echo "$total_cost"
}

# Get prompt score for current project
get_prompt_score() {
  local project_path="$1"
  local scores_file="$HOME/.claude/prompt_scores.json"

  # If scores file doesn't exist, return ?
  if [ ! -f "$scores_file" ]; then
    echo "?"
    return
  fi

  # Get score for current project (using full path as key)
  local score
  score=$(jq -r ".\"$project_path\".score // \"?\"" "$scores_file" 2>/dev/null)

  echo "${score:-?}"
}

# Get prompt comment for current project
get_prompt_comment() {
  local project_path="$1"
  local scores_file="$HOME/.claude/prompt_scores.json"

  # If scores file doesn't exist, return empty
  if [ ! -f "$scores_file" ]; then
    echo ""
    return
  fi

  # Get comment for current project (using full path as key)
  local comment
  comment=$(jq -r ".\"$project_path\".details.comment // \"\"" "$scores_file" 2>/dev/null)

  echo "${comment}"
}

# Get code review score for current project
get_code_review_score() {
  local project_path="$1"
  local scores_file="$HOME/.claude/code_review_scores.json"

  # Git リポジトリでない場合は ? を返す
  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "?"
    return
  fi

  # スコアファイルが存在しない場合は ? を返す
  if [ ! -f "$scores_file" ]; then
    echo "?"
    return
  fi

  # キャッシュされたスコアを取得（差分の有無に関わらず）
  local score
  score=$(jq -r ".\"$project_path\".score // \"?\"" "$scores_file" 2>/dev/null)

  # スコアが存在する場合はそのまま表示、存在しない場合は ? を表示
  echo "${score:-?}"
}

# Get code review comment for current project
get_code_review_comment() {
  local project_path="$1"
  local scores_file="$HOME/.claude/code_review_scores.json"

  # Git リポジトリでない場合は空を返す
  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo ""
    return
  fi

  # スコアファイルが存在しない場合は空を返す
  if [ ! -f "$scores_file" ]; then
    echo ""
    return
  fi

  # キャッシュされたコメントを取得
  local comment
  comment=$(jq -r ".\"$project_path\".details.comment // empty" "$scores_file" 2>/dev/null)
  echo "${comment}"
}

# Calculate token usage percentage
calculate_usage_percentage() {
  local total_tokens="$1"

  if [ "$MAX_CONTEXT" -eq 0 ]; then
    echo "0.0"
    return
  fi

  local usage_percent
  usage_percent=$(echo "scale=1; $total_tokens * 100 / $MAX_CONTEXT" | bc -l 2>/dev/null || echo "0")

  # Cap at 100%
  if (($(echo "$usage_percent > 100" | bc -l 2>/dev/null))); then
    echo "100.0"
  else
    echo "$usage_percent"
  fi
}

# Get token usage from transcript
get_token_usage() {
  local session_id="$1"
  local transcript_dir="$2"
  local transcript_file="$transcript_dir/$session_id.jsonl"

  if [ ! -f "$transcript_file" ]; then
    echo "0"
    return
  fi

  # Get last usage entry (cumulative)
  local last_usage
  last_usage=$(grep '"usage"' "$transcript_file" 2>/dev/null | tail -1 | jq '.message.usage' 2>/dev/null)

  if [ -z "$last_usage" ] || [ "$last_usage" = "null" ]; then
    echo "0"
    return
  fi

  # Sum all token types
  local input output cache_creation cache_read
  input=$(echo "$last_usage" | jq -r '.input_tokens // 0')
  output=$(echo "$last_usage" | jq -r '.output_tokens // 0')
  cache_creation=$(echo "$last_usage" | jq -r '.cache_creation_input_tokens // 0')
  cache_read=$(echo "$last_usage" | jq -r '.cache_read_input_tokens // 0')

  echo $((input + output + cache_creation + cache_read))
}

# Main
main() {
  # Read JSON from stdin
  local json_input
  json_input=$(cat)

  # Extract fields
  local model session_id current_dir
  model=$(echo "$json_input" | jq -r '.model.display_name // .model // "unknown"' 2>/dev/null)
  session_id=$(echo "$json_input" | jq -r '.session_id // ""' 2>/dev/null)
  current_dir=$(echo "$json_input" | jq -r '.workspace.current_dir // .cwd // "~"' 2>/dev/null)

  # Build project directory path
  local project_name transcript_dir
  project_name="${current_dir//[\/.]/-}"
  transcript_dir="$HOME/.claude/projects/$project_name"

  # Get token usage
  local total_tokens=0
  if [ -n "$session_id" ] && [ -d "$transcript_dir" ]; then
    total_tokens=$(get_token_usage "$session_id" "$transcript_dir")
  fi

  # Calculate usage percentage
  local usage_percent
  usage_percent=$(calculate_usage_percentage "$total_tokens")

  # Get today's cost
  local today_cost
  today_cost=$(get_cached_cost)
  today_cost=$(printf "%.2f" "$today_cost")

  # Get prompt score for current project (using full path)
  local prompt_score
  prompt_score=$(get_prompt_score "$current_dir")

  # Get prompt comment for current project
  local prompt_comment
  prompt_comment=$(get_prompt_comment "$current_dir")

  # Get code review score for current project (using full path)
  local review_score
  review_score=$(get_code_review_score "$current_dir")

  # Get code review comment for current project
  local review_comment
  review_comment=$(get_code_review_comment "$current_dir")

  # Get Git diff stats if in a git repository
  local git_stats=""

  # Change to the current working directory first
  cd "$current_dir" 2>/dev/null || true

  if [ -d .git ] || git rev-parse --git-dir >/dev/null 2>&1; then
    # Get current branch
    local branch
    branch=$(git branch --show-current 2>/dev/null || git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "detached")

    # Get diff stats (insertions and deletions)
    local stats
    stats=$(git diff --shortstat 2>/dev/null)

    if [ -n "$stats" ]; then
      # Parse insertions and deletions
      local insertions deletions
      insertions=$(echo "$stats" | grep -oE '[0-9]+ insertion' | grep -oE '[0-9]+' || echo "0")
      deletions=$(echo "$stats" | grep -oE '[0-9]+ deletion' | grep -oE '[0-9]+' || echo "0")

      # Format with colors (using terminal escape codes)
      git_stats="$branch +${insertions:-0}/-${deletions:-0}"
    else
      # No changes
      git_stats="$branch"
    fi
  else
    # Not a git repository
    git_stats="No git"
  fi

  # ANSI Color codes - Powerline スタイル用（One Dark 配色に最適化）
  # 背景色（#282c34 に合わせた交互配色）
  local BG_GRAY1='\033[48;5;236m' # Model - #30343c
  local BG_GRAY2='\033[48;5;237m' # Cost - #3e4249
  local BG_GRAY3='\033[48;5;236m' # Usage - #30343c
  local BG_GRAY4='\033[48;5;237m' # Score - #3e4249
  local BG_GRAY5='\033[48;5;236m' # Review - #30343c
  local BG_GRAY6='\033[48;5;237m' # Git - #3e4249

  # テキストカラー前景色（コントラストを確保）
  local FG_CYAN='\033[38;5;87m'     # 明るいシアン（Model 用）
  local FG_GREEN='\033[38;5;120m'   # 明るい緑（Cost 用）
  local FG_YELLOW='\033[38;5;228m'  # 明るい黄色（Usage 用）
  local FG_MAGENTA='\033[38;5;183m' # 明るいラベンダー（Score 用）
  local FG_ORANGE='\033[38;5;215m'  # 明るいオレンジ（Review 用）
  local FG_BLUE='\033[38;5;117m'    # 明るい青（Git 用）

  # 矢印の色（次のセグメントの背景色を前景色として使用）
  local ARROW_GRAY1='\033[38;5;238m' # グレー 1 矢印
  local ARROW_GRAY2='\033[38;5;240m' # グレー 2 矢印
  local ARROW_GRAY3='\033[38;5;242m' # グレー 3 矢印
  local ARROW_GRAY4='\033[38;5;239m' # グレー 4 矢印
  local ARROW_GRAY5='\033[38;5;241m' # グレー 5 矢印
  local ARROW_GRAY6='\033[38;5;237m' # グレー 6 矢印

  local RESET='\033[0m' # Reset

  # Powerline arrows (Nerd Font required)
  local ARROW='' # Powerline arrow

  # Output status line in 3 lines with blank lines for separation
  # Line 1: Model, Cost, Usage
  printf "${BG_GRAY1}${FG_CYAN}🤖 %s ${RESET}${BG_GRAY2}${ARROW_GRAY1}${ARROW}${RESET}${BG_GRAY2}${FG_GREEN} 💰 $%s ${RESET}${BG_GRAY3}${ARROW_GRAY2}${ARROW}${RESET}${BG_GRAY3}${FG_YELLOW} 💾 %s%% ${RESET}${ARROW_GRAY3}${ARROW}${RESET}\n" \
    "$model" "$today_cost" "$usage_percent"

  # Blank line with dim gray color
  local DIM_GRAY='\033[38;5;234m' # より薄いグレー (ほぼ背景色に近い)
  printf "%b - - - - -%b\n" "$DIM_GRAY" "$RESET"

  # Line 2: Prompt Score and Comment
  if [ -n "$prompt_comment" ]; then
    # 2 行目: プロンプトスコアとコメント
    local max_width=160
    if [ ${#prompt_comment} -gt $max_width ]; then
      prompt_comment="${prompt_comment:0:$max_width}..."
    fi
    printf "${BG_GRAY4}${FG_MAGENTA}💬 Prompt %s/100 ${RESET}${ARROW_GRAY4}${ARROW}${RESET}\n" "$prompt_score"
    printf "💬 %s${RESET}\n" "$prompt_comment"
  else
    printf "${BG_GRAY4}${FG_MAGENTA}💬 Prompt %s/100 ${RESET}${ARROW_GRAY4}${ARROW}${RESET}\n" "$prompt_score"
  fi

  # Blank line with dim gray color
  local DIM_GRAY='\033[38;5;234m' # より薄いグレー (ほぼ背景色に近い)
  printf "%b - - - - -%b\n" "$DIM_GRAY" "$RESET"

  # Line 3: Git and Review
  printf " ${BG_GRAY5}${FG_BLUE} Review %s/100 ${RESET}${BG_GRAY6}${ARROW_GRAY5}${ARROW}${RESET}${BG_GRAY6}${FG_ORANGE} %s ${RESET}${ARROW_GRAY6}${ARROW}${RESET}\n" \
    "$review_score" "$git_stats"

  # Show review comment if exists
  if [ -n "$review_comment" ]; then
    local max_width=320
    if [ ${#review_comment} -gt $max_width ]; then
      review_comment="${review_comment:0:$max_width}..."
    fi
    printf " %s${RESET}\n" "$review_comment"
  fi

  # Blank line with dim gray color
  local DIM_GRAY='\033[38;5;234m' # より薄いグレー (ほぼ背景色に近い)
  printf "%b - - - - -%b\n" "$DIM_GRAY" "$RESET"
}

main "$@"
