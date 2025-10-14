#!/usr/bin/env bash

# Get today's total cost from ccusage
get_today_cost() {
  local today_date
  today_date=$(date +%Y-%m-%d)
  local cost
  cost=$(ccusage daily --json 2>/dev/null | jq -r --arg date "$today_date" '.daily[] | select(.date == $date) | .totalCost // "0.00"' 2>/dev/null)

  if [ -z "$cost" ] || [ "$cost" = "null" ]; then
    echo "0.00"
  else
    printf "%.2f" "$cost" 2>/dev/null || echo "0.00"
  fi
}

# Get cached review score for current project
get_code_review_score() {
  local project_path="$1"
  local scores_file="$HOME/.claude/code_review_scores.json"

  if ! git rev-parse --git-dir >/dev/null 2>&1 || [ ! -f "$scores_file" ]; then
    echo "?"
    return
  fi

  local score
  score=$(jq -r ".\"$project_path\".score // \"?\"" "$scores_file" 2>/dev/null)
  echo "${score:-?}"
}

# Get cached review comment for current project
get_code_review_comment() {
  local project_path="$1"
  local scores_file="$HOME/.claude/code_review_scores.json"

  if ! git rev-parse --git-dir >/dev/null 2>&1 || [ ! -f "$scores_file" ]; then
    return
  fi

  jq -r ".\"$project_path\".details.comment // empty" "$scores_file" 2>/dev/null
}

# Main entry point
main() {
  local json_input
  json_input=$(cat)

  # Extract context from stdin JSON
  local model
  model=$(echo "$json_input" | jq -r '.model.display_name // .model // "unknown"' 2>/dev/null)
  local current_dir
  current_dir=$(echo "$json_input" | jq -r '.workspace.current_dir // .cwd // "~"' 2>/dev/null)

  # Get metrics
  local today_cost
  today_cost=$(get_today_cost)
  local review_score
  review_score=$(get_code_review_score "$current_dir")
  local review_comment
  review_comment=$(get_code_review_comment "$current_dir")

  # Get Git status
  cd "$current_dir" 2>/dev/null || true
  local git_stats="No git"

  if [ -d .git ] || git rev-parse --git-dir >/dev/null 2>&1; then
    local branch
    branch=$(git branch --show-current 2>/dev/null || git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "detached")
    local stats
    stats=$(git diff --shortstat 2>/dev/null)

    if [ -n "$stats" ]; then
      local insertions
      insertions=$(echo "$stats" | grep -oE '[0-9]+ insertion' | grep -oE '[0-9]+' || echo "0")
      local deletions
      deletions=$(echo "$stats" | grep -oE '[0-9]+ deletion' | grep -oE '[0-9]+' || echo "0")
      git_stats="$branch +${insertions:-0}/-${deletions:-0}"
    else
      git_stats="$branch"
    fi
  fi

  # ANSI Color codes
  local FG_CYAN='\033[38;5;87m'
  local FG_GREEN='\033[38;5;120m'
  local FG_ORANGE='\033[38;5;215m'
  local FG_BLUE='\033[38;5;117m'
  local DIM_GRAY='\033[38;5;234m'
  local RESET='\033[0m'

  # Line 1: Model & Cost
  printf "${FG_CYAN}🤖 %s${RESET} ${FG_GREEN}💰 \$%s${RESET}\n" "$model" "$today_cost"

  # Separator
  printf "%b - - - - -%b\n" "$DIM_GRAY" "$RESET"

  # Line 2: Review & Git
  printf "  ${FG_BLUE}Review %s/100${RESET} ${FG_ORANGE} %s${RESET}\n" "$review_score" "$git_stats"

  # Review comment (truncated to 480 chars)
  if [ -n "$review_comment" ]; then
    if [ ${#review_comment} -gt 480 ]; then
      review_comment="${review_comment:0:480}..."
    fi
    printf "  %s${RESET}\n" "$review_comment"
  fi

  # Separator
  printf "%b - - - - -%b\n" "$DIM_GRAY" "$RESET"
}

main "$@"
