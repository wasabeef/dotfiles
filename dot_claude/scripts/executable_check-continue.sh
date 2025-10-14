#!/bin/bash

# シンプル継続チェック
# 合い言葉がなければ「作業を再開してください」と伝える
#
# 合い言葉は CLAUDE.md で定義されている完了時の決まり文句
# 詳細: ~/.claude/CLAUDE.md の「作業完了報告のルール」を参照

COMPLETION_PHRASE="May the Force be with you."

# Stop hook から渡される JSON を読み取り
input_json=$(cat)

# transcript_path を抽出
transcript_path=$(echo "$input_json" | jq -r '.transcript_path // empty')

if [ -n "$transcript_path" ] && [ -f "$transcript_path" ]; then
  # 最後のメッセージ全体を取得（エラーメッセージも含む）
  last_entry=$(tail -n 1 "$transcript_path")

  # デバッグ用（必要に応じて有効化）
  # echo "Debug: last_entry=$last_entry" >&2

  # アシスタントメッセージのテキストを取得
  last_message=$(echo "$last_entry" | jq -r '.message.content[0].text // empty' 2>/dev/null || echo "")

  # エラーフィールドの様々な可能性をチェック
  error_message=$(echo "$last_entry" | jq -r '.message.error // .error // empty' 2>/dev/null || echo "")

  # メッセージ全体を文字列化してチェック（JSON の構造に関わらず）
  full_entry_text=$(echo "$last_entry" | jq -r '.' 2>/dev/null || echo "$last_entry")

  # Claude usage limit reached のチェック（複数の方法で）
  if echo "$error_message" | grep -qi "usage limit" ||
    echo "$last_message" | grep -qi "usage limit" ||
    echo "$full_entry_text" | grep -qi "usage limit"; then
    # Usage limit エラーの場合は何もしない（正常終了）
    exit 0
  fi

  # その他のエラーパターンの検出
  if echo "$error_message" | grep -qi "network error\|timeout\|connection refused" ||
    echo "$full_entry_text" | grep -qi "network error\|timeout\|connection refused"; then
    # ネットワークエラーの場合は何もしない（正常終了）
    exit 0
  fi

  # /compact 関連のパターンの検出（エラーメッセージとして扱う）
  if echo "$error_message" | grep -qi "Context low.*Run /compact to compact" ||
    echo "$full_entry_text" | grep -qi "Context low.*Run /compact to compact"; then
    # /compact 関連のメッセージの場合は何もしない（正常終了）
    exit 0
  fi

  # Stop hook feedback の繰り返しパターンの検出
  if echo "$last_message" | grep -qi "Stop hook feedback" ||
    echo "$full_entry_text" | grep -qi "Stop hook feedback" ||
    echo "$last_message" | grep -qi "作業を再開してください"; then
    # Stop hook feedback の繰り返しパターンの場合は何もしない（正常終了）
    exit 0
  fi

  # 計画提示関連のパターンチェック（修正：承認済みの場合は継続）
  if echo "$last_message" | grep -qi "User approved Claude's plan" ||
    echo "$full_entry_text" | grep -qi "User approved Claude's plan"; then
    # 計画承認済み → 作業継続（ブロックしない）
    exit 0
  fi

  # y/n で確認を求められている場合
  if echo "$last_message" | grep -qi "y/n" ||
    echo "$full_entry_text" | grep -qi "y/n"; then
    # 計画承認済み → 作業継続（ブロックしない）
    exit 0
  fi

  # /spec 関連の作業パターンチェック
  if echo "$last_message" | grep -qi "spec" ||
    echo "$last_message" | grep -qi "spec-driven" ||
    echo "$last_message" | grep -qi "requirements\.md\\|design\.md\\|tasks\.md"; then
    # /spec 関連の作業中は継続を促さない（正常終了）
    exit 0
  fi

  # 合い言葉チェック（最初に確認）
  if echo "$last_message" | grep -q "$COMPLETION_PHRASE"; then
    # 合い言葉があれば何もしない（正常終了）
    exit 0
  fi

  # 無限ループ防止: 直前のやり取りをチェック
  if [ -f "$transcript_path" ]; then
    # 最後の3行を取得（user -> assistant -> user のパターン確認用）
    last_3_lines=$(tail -n 3 "$transcript_path" 2>/dev/null)

    # 直前が「Stop hook feedback → May the Force → Stop hook feedback」のパターンかチェック
    if echo "$last_3_lines" | grep -q "$COMPLETION_PHRASE" && \
       echo "$last_3_lines" | grep -q "Stop hook feedback"; then
      # このパターンの場合は無限ループ防止のため終了
      exit 0
    fi

    # 連続で同じ Stop hook feedback が出ている場合もチェック
    last_2_messages=$(tail -n 2 "$transcript_path" | jq -r '.message.content[0].text // empty' 2>/dev/null)
    if echo "$last_2_messages" | grep -c "作業を再開してください" | grep -q "2"; then
      # 連続で同じメッセージなら無限ループ防止
      exit 0
    fi
  fi
fi

# 合い言葉がなければ継続を促す
cat <<EOF
{
  "decision": "block",
  "reason": "作業を再開してください。\n  続ける作業がない場合は \`$COMPLETION_PHRASE\` を出力して終了してください。"
}
EOF
