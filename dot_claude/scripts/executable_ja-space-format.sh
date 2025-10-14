#!/bin/bash
set -euo pipefail

# 日本語・英語混在テキストの自動スペースフォーマット（v8 - 除外リスト対応版）
#
# 実装されたルール:
# 1. 全角文字（日本語）と半角英数字の間に半角スペース挿入
# 2. 括弧内容による判定: 英語のみはスペースなし、日本語含む場合はスペースあり
# 3. 数学記号（Big O 記法、上付き・下付き文字）の適切な処理
# 4. 中黒（・）の前後はスペースを入れない
# 5. 句読点（。、）の前後はスペースを入れない
# 6. コードブロック、インラインコード、文字列の保護
# 7. シェルスクリプトの構文（if [ など）を正しく処理
# 8. 除外リスト（ja-space-exclusions.json）の単語はスペース挿入をスキップ

# ファイルパス取得
if [ -n "${1:-}" ]; then
  file_path="$1"
else
  file_path=$(jq -r '.tool_input.file_path // empty' <<<"${CLAUDE_TOOL_INPUT:-$(cat)}")
fi

# 基本チェック
[ -z "$file_path" ] && exit 0
[ ! -f "$file_path" ] && exit 0
[ ! -r "$file_path" ] && exit 0
[ ! -w "$file_path" ] && exit 0

# 自分自身を除外（自己破損防止）
target_file="$(basename "$file_path")"
if [[ "$target_file" == "ja-space-format"* && "$target_file" == *".sh" ]]; then
  exit 0
fi

# 一時ファイルで処理
temp_file=$(mktemp)
trap 'rm -f "$temp_file"' EXIT

# 除外リストのパス
exclusions_file="$(dirname "$0")/ja-space-exclusions.json"

# Python スクリプトで処理（v7 - 完全再設計 + 除外リスト対応）
python3 - "$file_path" "$temp_file" "$exclusions_file" << 'EOF'
import re
import sys
import json
import os

file_path = sys.argv[1]
output_path = sys.argv[2]
exclusions_file = sys.argv[3] if len(sys.argv) > 3 else None

# 除外リストを読み込み
exclusions = []
if exclusions_file and os.path.exists(exclusions_file):
    try:
        with open(exclusions_file, 'r', encoding='utf-8') as f:
            data = json.load(f)
            exclusions = data.get('exclusions', [])
    except:
        pass  # 除外リストの読み込みに失敗してもスキップ

# ファイル内容を読み込み
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# 保護マーカーを使用（絶対に実際のコードに出現しない形式）
PROTECT_PREFIX = "\x00PROT"
PROTECT_SUFFIX = "TORP\x00"
protected_contents = []

def protect_content(text):
    """保護対象の内容を特殊マーカーで置換"""
    protected_contents.append(text)
    return f'{PROTECT_PREFIX}{len(protected_contents) - 1}{PROTECT_SUFFIX}'

def restore_protected(text):
    """保護した内容を復元"""
    pattern = re.compile(re.escape(PROTECT_PREFIX) + r'(\d+)' + re.escape(PROTECT_SUFFIX))
    def replacer(match):
        idx = int(match.group(1))
        if idx < len(protected_contents):
            return protected_contents[idx]
        return match.group(0)
    return pattern.sub(replacer, text)

# Step 1: コードブロック（```...```）を保護
content = re.sub(r'```[\s\S]*?```', lambda m: protect_content(m.group(0)), content)

# Step 2: インラインコード（`...`）を保護
content = re.sub(r'`[^`]+`', lambda m: protect_content(m.group(0)), content)

# Step 3: 文字列リテラルを保護（ダブルクォート、シングルクォート）
# エスケープされた引用符も考慮
content = re.sub(
    r'"(?:[^"\\]|\\.)*"|\'(?:[^\'\\]|\\.)*\'',
    lambda m: protect_content(m.group(0)),
    content
)

# Step 4: シェルスクリプトの特殊構文を保護（if [ など）
# if, elif, while, until の後の [ を保護
content = re.sub(
    r'\b(if|elif|while|until)\s+\[',
    lambda m: protect_content(m.group(0)),
    content
)

# Step 5: jq のデフォルト値演算子を保護（// の後の値）
content = re.sub(
    r'//\s*(?:"[^"]*"|\'[^\']*\'|[a-zA-Z_][a-zA-Z0-9_]*|empty|null|\d+)',
    lambda m: protect_content(m.group(0)),
    content
)

# Step 6: 除外リストの単語を保護
for exclusion in exclusions:
    # エスケープして正規表現として安全に使用
    # \b は ASCII のみなので、日本語を含む単語では使えない
    escaped = re.escape(exclusion)
    content = re.sub(
        rf'{escaped}',
        lambda m: protect_content(m.group(0)),
        content
    )

# CJK文字の判定
def is_cjk_char(char):
    """CJK文字（日本語・中国語・韓国語）かどうかを判定"""
    code = ord(char)
    return (
        (0x3040 <= code <= 0x309F) or  # ひらがな
        (0x30A0 <= code <= 0x30FF) or  # カタカナ
        (0x4E00 <= code <= 0x9FAF) or  # CJK統合漢字
        (0x3400 <= code <= 0x4DBF) or  # CJK拡張A
        (0xF900 <= code <= 0xFAFF) or  # CJK互換漢字
        (0x2E80 <= code <= 0x2FDF) or  # CJK部首
        (0x3000 <= code <= 0x303F)     # CJKの記号と句読点
    )

# 基本的なスペース挿入（CJK文字と非CJK英数字の間のみ）
def add_spaces_between_cjk_and_alnum(text):
    result = []
    prev_char = ''

    for i, char in enumerate(text):
        if i == 0:
            result.append(char)
            prev_char = char
            continue

        prev_is_cjk = is_cjk_char(prev_char) and prev_char not in '・。、'
        curr_is_cjk = is_cjk_char(char) and char not in '・。、'
        # 非CJK英数字の判定
        prev_is_alnum = prev_char.isalnum() and not is_cjk_char(prev_char)
        curr_is_alnum = char.isalnum() and not is_cjk_char(char)

        # CJK文字と非CJK英数字の間にのみスペースを挿入
        if (prev_is_cjk and curr_is_alnum) or (prev_is_alnum and curr_is_cjk):
            result.append(' ')

        result.append(char)
        prev_char = char

    return ''.join(result)

# スペース処理を実行
content = add_spaces_between_cjk_and_alnum(content)

# 半角括弧の処理
def add_space_before_paren(match):
    char = match.group(1)
    paren = match.group(2)
    if is_cjk_char(char):
        return char + ' ' + paren
    return char + paren

def add_space_after_paren(match):
    paren = match.group(1)
    char = match.group(2)
    if is_cjk_char(char):
        return paren + ' ' + char
    return paren + char

content = re.sub(r'(.)([(\[])', add_space_before_paren, content)
content = re.sub(r'([\)\]])(.)' , add_space_after_paren, content)

# 半角英数字と括弧の間の既存スペース（改行以外）を削除
# ただし、保護されたコンテンツは除外
if PROTECT_PREFIX not in content:
    # 保護されたコンテンツがない場合のみ適用
    content = re.sub(r'([a-zA-Z0-9])[ \t]+([(\[])', r'\1\2', content)
    content = re.sub(r'([\)\]])[ \t]+([a-zA-Z0-9])', r'\1\2', content)

# 全角括弧内の先頭末尾に入ったスペースを削除
content = re.sub(r'（[ \t]+', '（', content)
content = re.sub(r'[ \t]+）', '）', content)
content = re.sub(r'「[ \t]+', '「', content)
content = re.sub(r'[ \t]+」', '」', content)
content = re.sub(r'『[ \t]+', '『', content)
content = re.sub(r'[ \t]+』', '』', content)

# 助詞の前のスペースを削除
particles = ['は', 'が', 'を', 'に', 'の', 'へ', 'で', 'から', 'まで', 'と', 'も', 'や']
for particle in particles:
    content = re.sub(f'([ぁ-ゟァ-ヿ一-鿿々〆〤]) {particle}', rf'\1{particle}', content)

# パーセント記号の処理
def add_space_after_percent(match):
    percent = match.group(1)
    char = match.group(2)
    if is_cjk_char(char):
        return percent + ' ' + char
    return percent + char

content = re.sub(r'(%)(.)', add_space_after_percent, content)

# Step 7: 保護した内容をすべて復元
content = restore_protected(content)

# 復元確認 - NULL文字が残っていないか確認
if '\x00' in content:
    # エラー処理：NULL文字が残っている場合は元のファイルを変更しない
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

# 結果を出力
with open(output_path, 'w', encoding='utf-8') as f:
    f.write(content)
EOF

mv "$temp_file" "$file_path"