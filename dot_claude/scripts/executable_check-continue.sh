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
  # 最後のアシスタントメッセージのテキストを取得
  last_message=$(tail -n 1 "$transcript_path" | jq -r '.message.content[0].text // empty')

  # 合い言葉チェック
  if echo "$last_message" | grep -q "$COMPLETION_PHRASE"; then
    # 合い言葉があれば何もしない（正常終了）
    exit 0
  fi
fi

# 合い言葉がなければ継続を促す
cat <<EOF
{
  "decision": "block",
  "reason": "作業を再開してください。続ける作業がない場合は \`$COMPLETION_PHRASE\` を出力して終了してください。"
}
EOF
