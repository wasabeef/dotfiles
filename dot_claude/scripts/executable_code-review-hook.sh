#!/bin/bash

# Stop hook 用のコードレビュースクリプト
# Git diff がある場合、バックグラウンドでコードレビューを実行

# 標準入力から JSON を読み込む（Stop hook は JSON を受け取らない場合もある）
if [ ! -t 0 ]; then
  json_input=$(cat)
fi

# Git リポジトリでない場合はスキップ
if ! git rev-parse --git-dir >/dev/null 2>&1; then
  exit 0
fi

# Git diff を確認（ステージされた変更と作業ディレクトリの変更の両方）
diff_content=$(git diff HEAD 2>/dev/null)

# diff がある場合のみレビューを実行
if [ -n "$diff_content" ]; then
  # バックグラウンドでレビューを実行（UI をブロックしない）
  {
    # コードレビューを実行（hook モード）
    ~/.claude/scripts/code-review-with-codex-v2.sh hook 2>/dev/null
  } &
fi

# 何も出力しない（JSON 応答は不要）
exit 0
