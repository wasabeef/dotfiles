#!/usr/bin/env bash

# Constants
readonly SCORES_FILE="$HOME/.claude/code_review_scores.json"
readonly COMMENT_MAX_LENGTH=480

# ANSI Color codes
readonly FG_CYAN='\033[38;5;87m'
readonly FG_GREEN='\033[38;5;120m'
readonly FG_ORANGE='\033[38;5;215m'
readonly FG_BLUE='\033[38;5;117m'
readonly DIM_GRAY='\033[38;5;234m'
readonly RESET='\033[0m'

# Get today's total cost from ccusage
get_today_cost() {
  local today_date
  today_date=$(date +%Y-%m-%d)

  local cost
  cost=$(bunx ccusage daily --json 2>/dev/null | \
    jq -r --arg date "$today_date" '.daily[] | select(.date == $date) | .totalCost // "0.00"' 2>/dev/null)

  if [ -z "$cost" ] || [ "$cost" = "null" ]; then
    echo "0.00"
  else
    printf "%.2f" "$cost" 2>/dev/null || echo "0.00"
  fi
}

# Check if we're in a git repository with scores file
# Args: $1=project_path
is_review_available() {
  local project_path="$1"
  # .git がディレクトリまたはファイル（worktree の場合）であることを確認
  [ -f "$SCORES_FILE" ] && { [ -d "$project_path/.git" ] || [ -f "$project_path/.git" ]; }
}

# Get diff content with branch-based review support
# Args: $1=project_path
# Returns: diff content via stdout
get_diff_content() {
  local project_path="$1"
  local diff_content=""

  cd "$project_path" 2>/dev/null || return

  # base ブランチを検出（main, master, develop など）
  local base_branch
  base_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
  if [ -z "$base_branch" ]; then
    # フォールバック: よくある base ブランチ名を試す
    for candidate in main master develop; do
      if git show-ref --verify --quiet refs/remotes/origin/${candidate} 2>/dev/null; then
        base_branch="$candidate"
        break
      fi
    done
  fi

  # ブランチが base から分岐している場合、ブランチ全体の変更をレビュー
  if [ -n "$base_branch" ] && git merge-base --is-ancestor origin/${base_branch} HEAD 2>/dev/null; then
    local current_branch
    current_branch=$(git branch --show-current 2>/dev/null)

    # base ブランチで直接作業していない場合のみブランチベースレビュー
    if [ -n "$current_branch" ] && [ "$current_branch" != "$base_branch" ]; then
      local branch_diff
      branch_diff=$(git diff origin/${base_branch}...HEAD 2>/dev/null)

      # ブランチに実際にコミットがある場合のみブランチベースレビュー
      if [ -n "$branch_diff" ]; then
        diff_content="$branch_diff"
      fi
    fi
  fi

  # フォールバック: base ブランチで作業中、ブランチにコミットがない、または検出できない場合は HEAD との差分
  if [ -z "$diff_content" ]; then
    diff_content=$(git diff HEAD 2>/dev/null)
  fi

  # untracked ファイルも含める
  local untracked_files
  untracked_files=$(git ls-files --others --exclude-standard 2>/dev/null)
  if [ -n "$untracked_files" ]; then
    while IFS= read -r file; do
      if [ -f "$file" ]; then
        diff_content="${diff_content}
diff --git a/$file b/$file
new file mode 100644
index 0000000..0000000
--- /dev/null
+++ b/$file
$(cat "$file" 2>/dev/null | sed 's/^/+/')"
      fi
    done <<< "$untracked_files"
  fi

  echo "$diff_content"
}

# Check if there are any uncommitted changes (staged, unstaged, or untracked)
# Args: $1=project_path
has_diff() {
  local project_path="$1"
  local diff_output
  diff_output=$(get_diff_content "$project_path")
  [ -n "$diff_output" ]
}

# Check if review data matches current diff (including untracked files)
# Args: $1=project_path
is_review_current() {
  local project_path="$1"

  # Calculate current diff hash (including untracked files and branch-based diff)
  local diff_content
  diff_content=$(get_diff_content "$project_path")

  local current_hash
  current_hash=$(echo "$diff_content" | shasum -a 256 | cut -d' ' -f1)

  # Get cached hash
  local cache_dir="$HOME/.claude/cache/code-review"
  local safe_project_name
  safe_project_name="${project_path//[^a-zA-Z0-9]/_}"
  local cache_file="$cache_dir/${safe_project_name}.cache"

  if [ ! -f "$cache_file" ]; then
    return 1
  fi

  local cached_hash
  cached_hash=$(cat "$cache_file" 2>/dev/null)

  [ "$current_hash" = "$cached_hash" ]
}

# Get review data (score or comment) for a specific engine
# Args: $1=project_path, $2=engine (codex|claude), $3=data_type (score|comment)
get_review_data() {
  local project_path="$1"
  local engine="$2"
  local data_type="$3"

  if ! is_review_available "$project_path"; then
    [ "$data_type" = "score" ] && echo "?" || return
    return
  fi

  local jq_path
  if [ "$data_type" = "score" ]; then
    jq_path=".\"$project_path\".$engine.score"
  else
    jq_path=".\"$project_path\".$engine.details.comment"
  fi

  if [ "$data_type" = "score" ]; then
    local result
    result=$(jq -r "$jq_path // \"?\"" "$SCORES_FILE" 2>/dev/null)
    echo "${result:-?}"
  else
    jq -r "$jq_path // empty" "$SCORES_FILE" 2>/dev/null
  fi
}

# Get Git status information
get_git_status() {
  local current_dir="$1"

  cd "$current_dir" 2>/dev/null || true

  if ! { [ -d .git ] || git rev-parse --git-dir >/dev/null 2>&1; }; then
    echo "No git"
    return
  fi

  local branch
  branch=$(git branch --show-current 2>/dev/null || \
           git rev-parse --abbrev-ref HEAD 2>/dev/null || \
           echo "detached")

  local stats
  stats=$(git diff --shortstat 2>/dev/null)

  if [ -z "$stats" ]; then
    echo "$branch"
    return
  fi

  local insertions
  insertions=$(echo "$stats" | grep -oE '[0-9]+ insertion' | grep -oE '[0-9]+' || echo "0")
  local deletions
  deletions=$(echo "$stats" | grep -oE '[0-9]+ deletion' | grep -oE '[0-9]+' || echo "0")

  echo "$branch +${insertions:-0}/-${deletions:-0}"
}

# Truncate text to maximum length
truncate_text() {
  local text="$1"
  local max_length="${2:-$COMMENT_MAX_LENGTH}"

  if [ ${#text} -gt "$max_length" ]; then
    echo "${text:0:$max_length}..."
  else
    echo "$text"
  fi
}

# Get formatted timestamp for review
# Args: $1=project_path, $2=engine (codex|claude)
get_review_timestamp_formatted() {
  local project_path="$1"
  local engine="$2"

  if ! is_review_available "$project_path"; then
    echo ""
    return
  fi

  local timestamp
  timestamp=$(jq -r ".\"$project_path\".\"$engine\".timestamp // empty" "$SCORES_FILE" 2>/dev/null)

  if [ -z "$timestamp" ] || [ "$timestamp" = "null" ]; then
    echo ""
    return
  fi

  # ISO 8601 UTC 形式からローカル時刻（JST）にフォーマット (YYYY/MM/DD HH:MM)
  # 1. UTC として Unix epoch に変換
  # 2. epoch をローカルタイムゾーン（JST）で表示
  local epoch
  epoch=$(TZ=UTC date -j -f "%Y-%m-%dT%H:%M:%S" "${timestamp%Z}" "+%s" 2>/dev/null)
  if [ -n "$epoch" ]; then
    date -r "$epoch" "+%Y/%m/%d %H:%M" 2>/dev/null || echo ""
  else
    echo ""
  fi
}

# Display review section (score and comment)
display_review_section() {
  local engine="$1"
  local score="$2"
  local comment="$3"
  local label="$4"
  local timestamp="$5"

  if [ -n "$timestamp" ]; then
    printf "  ${FG_BLUE}%s %s/100 %s${RESET}\n" "$label" "$score" "$timestamp"
  else
    printf "  ${FG_BLUE}%s %s/100${RESET}\n" "$label" "$score"
  fi

  if [ -n "$comment" ]; then
    local truncated_comment
    truncated_comment=$(truncate_text "$comment")
    printf "  %s${RESET}\n" "$truncated_comment"
  fi
}

# Print separator line
print_separator() {
  printf "%b - - - - -%b\n" "$DIM_GRAY" "$RESET"
}

# Get time elapsed since last review
# Args: $1=project_path, $2=engine (codex|claude)
get_time_since_review() {
  local project_path="$1"
  local engine="$2"

  if ! is_review_available "$project_path"; then
    echo ""
    return
  fi

  local timestamp
  timestamp=$(jq -r ".\"$project_path\".\"$engine\".timestamp // empty" "$SCORES_FILE" 2>/dev/null)

  if [ -z "$timestamp" ] || [ "$timestamp" = "null" ]; then
    echo ""
    return
  fi

  local review_time
  review_time=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "$timestamp" "+%s" 2>/dev/null || echo "")

  if [ -z "$review_time" ]; then
    echo ""
    return
  fi

  local current_time
  current_time=$(date +%s)
  local elapsed=$((current_time - review_time))

  if [ $elapsed -lt 60 ]; then
    echo "just now"
  elif [ $elapsed -lt 3600 ]; then
    echo "$((elapsed / 60))m ago"
  elif [ $elapsed -lt 86400 ]; then
    echo "$((elapsed / 3600))h ago"
  else
    echo "$((elapsed / 86400))d ago"
  fi
}

# Main entry point
main() {
  local json_input
  json_input=$(cat)

  # Debug: Log input JSON (uncomment when troubleshooting)
  # echo "=== $(date) ===" >> /tmp/statusline_debug.log
  # echo "$json_input" >> /tmp/statusline_debug.log

  # Extract context from stdin JSON
  local model
  model=$(echo "$json_input" | jq -r '.model.display_name // .model // "unknown"' 2>/dev/null)
  local current_dir
  current_dir=$(echo "$json_input" | jq -r '.workspace.current_dir // .cwd // "~"' 2>/dev/null)

  # Get metrics
  local today_cost
  today_cost=$(get_today_cost)

  local git_stats
  git_stats=$(get_git_status "$current_dir")

  # Line 1: Model & Cost & Git
  printf "${FG_CYAN}🤖 %s${RESET} ${FG_GREEN}💰 \$%s${RESET} ${FG_ORANGE}  %s${RESET}\n" \
    "$model" "$today_cost" "$git_stats"

  print_separator

  # Show review sections if there are uncommitted changes
  if has_diff "$current_dir"; then
    local codex_score
    codex_score=$(get_review_data "$current_dir" "codex" "score")
    local claude_score
    claude_score=$(get_review_data "$current_dir" "claude" "score")

    # レビュー結果が存在する場合は常に表示
    if [ -n "$codex_score" ] || [ -n "$claude_score" ]; then
      local codex_comment
      codex_comment=$(get_review_data "$current_dir" "codex" "comment")
      local claude_comment
      claude_comment=$(get_review_data "$current_dir" "claude" "comment")

      # Codex Review Section
      if [ -n "$codex_score" ]; then
        local codex_timestamp
        codex_timestamp=$(get_review_timestamp_formatted "$current_dir" "codex")
        display_review_section "codex" "$codex_score" "$codex_comment" "Codex Review" "$codex_timestamp"
        print_separator
      fi

      # Claude Review Section
      if [ -n "$claude_score" ]; then
        local claude_timestamp
        claude_timestamp=$(get_review_timestamp_formatted "$current_dir" "claude")
        display_review_section "claude" "$claude_score" "$claude_comment" "Claude Review" "$claude_timestamp"
        print_separator
      fi
    else
      # レビュー結果が存在しない場合のみ pending 表示
      print_separator
      printf "  %b⏳ Review pending...%b\n" "$FG_BLUE" "$RESET"
      print_separator
    fi
  fi
}

main "$@"
