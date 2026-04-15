#!/bin/bash

# Stop hook 用のコードレビュースクリプト
# Git diff がある場合、バックグラウンドでコードレビューを実行

# デバッグログ（5MB でローテーション）
log_file="$HOME/.claude/logs/code-review-hook.log"
mkdir -p "$(dirname "$log_file")"
if [ -f "$log_file" ] && [ "$(stat -f%z "$log_file" 2>/dev/null || echo 0)" -gt 5242880 ]; then
  mv -f "$log_file" "${log_file}.old"
fi
echo "=== $(date '+%Y-%m-%d %H:%M:%S') Stop hook executed ===" >> "$log_file"

# 標準入力を読み捨てる（hook によっては JSON を送信する場合がある）
if [ ! -t 0 ]; then
  cat >/dev/null
fi

echo "  Current directory: $(pwd)" >> "$log_file"

# Git リポジトリ判定
IS_GIT_REPO=false
if git rev-parse --git-dir >/dev/null 2>&1; then
  IS_GIT_REPO=true
fi

# 現在のディレクトリ名が除外対象の場合はスキップ（非 Git の場合のみ）
if [ "$IS_GIT_REPO" = false ]; then
  current_dir_name=$(basename "$(pwd)")
  if echo "$current_dir_name" | grep -qE "^(\.claude|\.git|node_modules|dist|build|vendor|__pycache__|\.venv|coverage|\.next|\.nuxt|\.cache|\.turbo)$"; then
    echo "  Skipping excluded directory: $current_dir_name" >> "$log_file"
    exit 0
  fi
fi

has_changes=false

if [ "$IS_GIT_REPO" = true ]; then
  # Git diff を確認（ブランチベース + untracked ファイル含む）
  # base ブランチ検出
  base_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
  if [ -z "$base_branch" ]; then
    for candidate in main master develop; do
      if git show-ref --verify --quiet refs/remotes/origin/${candidate} 2>/dev/null; then
        base_branch="$candidate"
        break
      fi
    done
  fi

  diff_content=""

  # ブランチベースレビュー（コミットがある場合）
  if [ -n "$base_branch" ] && git merge-base --is-ancestor origin/${base_branch} HEAD 2>/dev/null; then
    current_branch=$(git branch --show-current 2>/dev/null)
    if [ -n "$current_branch" ] && [ "$current_branch" != "$base_branch" ]; then
      branch_diff=$(git diff origin/${base_branch}...HEAD 2>/dev/null)
      if [ -n "$branch_diff" ]; then
        diff_content="$branch_diff"
      fi
    fi
  fi

  # フォールバック: working tree
  if [ -z "$diff_content" ]; then
    diff_content=$(git diff HEAD 2>/dev/null)
  fi

  # untracked ファイルもチェック
  untracked=$(git ls-files --others --exclude-standard 2>/dev/null)

  # diff または untracked ファイルがある場合
  if [ -n "$diff_content" ] || [ -n "$untracked" ]; then
    has_changes=true
    echo "  Git: Changes detected (diff: $(echo "$diff_content" | wc -l | tr -d ' ') lines, untracked: $(echo "$untracked" | wc -l | tr -d ' ') files)" >> "$log_file"
  fi
else
  # 非 Git: ディレクトリにファイルがあればレビュー対象
  file_count=$(find . -type f \
    ! -path "*/.git/*" \
    ! -path "*/.claude/*" \
    ! -path "*/node_modules/*" \
    ! -path "*/dist/*" \
    ! -path "*/build/*" \
    ! -path "*/vendor/*" \
    ! -path "*/__pycache__/*" \
    ! -path "*/.venv/*" \
    ! -path "*/coverage/*" \
    ! -path "*/.next/*" \
    ! -path "*/.nuxt/*" \
    ! -path "*/.cache/*" \
    ! -path "*/.turbo/*" \
    2>/dev/null | wc -l | tr -d ' ')

  if [ "$file_count" -gt 0 ]; then
    has_changes=true
    echo "  Non-Git: Found $file_count files to review" >> "$log_file"
  fi
fi

# 変更がある場合のみレビューを実行
if [ "$has_changes" = true ]; then
  echo "  Starting code review..." >> "$log_file"

  # コードレビューを実行（hook モード）
  # 完全にバックグラウンドで実行し、stdout/stderr を切り離す
  nohup ~/.claude/scripts/code-review-dual.sh hook >> "$log_file" 2>&1 </dev/null &

  # プロセスを完全に切り離す（Claude 再起動時の出力漏れ防止）
  disown

  echo "  Code review script started in background (PID: $!)" >> "$log_file"
else
  echo "  No changes detected, skipping review" >> "$log_file"
fi

# 何も出力しない（JSON 応答は不要）
exit 0
