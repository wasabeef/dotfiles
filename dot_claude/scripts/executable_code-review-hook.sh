#!/bin/bash

# Stop hook 用のコードレビュースクリプト
# Git diff がある場合、バックグラウンドでコードレビューを実行

# デバッグログ
log_file="$HOME/.claude/logs/code-review-hook.log"
mkdir -p "$(dirname "$log_file")"
echo "=== $(date '+%Y-%m-%d %H:%M:%S') Stop hook executed ===" >> "$log_file"

# 標準入力を読み捨てる（hook によっては JSON を送信する場合がある）
if [ ! -t 0 ]; then
  cat >/dev/null
fi

# Git リポジトリでない場合はスキップ
if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "  Not a git repository, skipping" >> "$log_file"
  exit 0
fi

echo "  Current directory: $(pwd)" >> "$log_file"

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

# diff または untracked ファイルがある場合のみレビューを実行
if [ -n "$diff_content" ] || [ -n "$untracked" ]; then
  echo "  Changes detected (diff: $(echo "$diff_content" | wc -l | tr -d ' ') lines, untracked: $(echo "$untracked" | wc -l | tr -d ' ') files)" >> "$log_file"
  echo "  Starting code review..." >> "$log_file"

  # コードレビューを実行（hook モード）
  # nohup で切り離されるため、ここでは & 不要
  ~/.claude/scripts/code-review-dual.sh hook >> "$log_file" 2>&1

  echo "  Code review script executed" >> "$log_file"
else
  echo "  No changes detected, skipping review" >> "$log_file"
fi

# 何も出力しない（JSON 応答は不要）
exit 0
