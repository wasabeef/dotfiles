#!/bin/bash

# Codex と Claude の両方を使用して Git diff のコードレビューを行うスクリプト
# hook モード専用 - JSON にスコアを保存（デュアルエンジン版）

# モード判定を最初に実行
REVIEW_MODE="${1:-direct}"

# hook モードの場合、即座にバックグラウンド化（出力漏れを防ぐ）
if [ "$REVIEW_MODE" = "hook" ]; then
  # setsid を使って完全に TTY から分離
  # Homebrew の util-linux を優先、なければフォールバック
  SETSID_CMD=""
  for candidate in /opt/homebrew/opt/util-linux/bin/setsid /usr/local/opt/util-linux/bin/setsid; do
    if [ -x "$candidate" ]; then
      SETSID_CMD="$candidate"
      break
    fi
  done

  if [ -n "$SETSID_CMD" ]; then
    # setsid で TTY から完全に分離してバックグラウンド実行
    (
      $SETSID_CMD "$0" "background" </dev/null >/dev/null 2>&1 &
    ) &
  else
    # setsid がない場合はフォールバック（二重フォーク）
    (
      "$0" "background" </dev/null >/dev/null 2>&1 &
    ) &
  fi
  exit 0
fi

# background モードの場合、ログファイルにリダイレクト
if [ "$REVIEW_MODE" = "background" ]; then
  # stdout を /dev/null に（JSON 出力が新セッションに漏れるのを防ぐ）
  # stderr はログファイルに（エラーメッセージを記録）
  log_file="$HOME/.claude/logs/code-review-background.log"
  mkdir -p "$(dirname "$log_file")"
  exec >/dev/null 2>> "$log_file"
  echo "=== $(date '+%Y-%m-%d %H:%M:%S') Background review started ===" >&2
  echo "Project: $(pwd)" >&2

  # PID ファイルで排他制御（実際の background プロセスの PID を記録）
  _pid_dir="$HOME/.claude/cache/code-review"
  mkdir -p "$_pid_dir"
  _safe_name="$(pwd | sed 's/[^a-zA-Z0-9]/_/g')"
  _pid_file="$_pid_dir/${_safe_name}.pid"

  if [ -f "$_pid_file" ]; then
    _old_pid=$(cat "$_pid_file" 2>/dev/null)
    if [ -n "$_old_pid" ] && kill -0 "$_old_pid" 2>/dev/null; then
      echo "Skipping: another review already running (PID: $_old_pid)" >&2
      exit 0
    fi
  fi
  echo "$$" > "$_pid_file"

  # 終了時に PID ファイルを削除
  trap 'rm -f "$_pid_file"' EXIT
fi

# ANSI Color codes
readonly WHITE='\033[97m'
readonly RESET='\033[0m'

# 除外パターン（Git/非Git共通）
EXCLUDE_DIRS="node_modules|\.git|\.claude|dist|build|vendor|__pycache__|\.venv|coverage|\.next|\.nuxt|\.cache|\.turbo"
MAX_FILE_SIZE=1048576  # 1MB

# バイナリファイル判定
is_binary_file() {
  local file="$1"
  # file コマンドでバイナリ判定（テキスト系は除外）
  local file_type
  file_type=$(file -b "$file" 2>/dev/null)
  # テキスト系は明示的に許可
  if echo "$file_type" | grep -qiE 'text|script|source|json|xml|html|css|markdown'; then
    return 1
  fi
  # バイナリ系は除外
  if echo "$file_type" | grep -qiE 'executable|binary|data|image|audio|video|archive|compressed|ELF|Mach-O'; then
    return 0
  fi
  # NUL バイト検出（最初の8KB）
  if head -c 8192 "$file" 2>/dev/null | LC_ALL=C grep -q "$(printf '\x00')"; then
    return 0
  fi
  return 1
}

# 非 Git 環境用: ディレクトリ全体を diff 形式で生成
generate_directory_diff() {
  local dir="${1:-.}"
  local diff_output=""

  while IFS= read -r -d '' file; do
    # サイズチェック
    local file_size
    file_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo 0)
    if [ "$file_size" -gt "$MAX_FILE_SIZE" ]; then
      continue
    fi

    # バイナリチェック
    if is_binary_file "$file"; then
      continue
    fi

    # diff 形式で追加
    local rel_path="${file#$dir/}"
    diff_output="${diff_output}
diff --git a/$rel_path b/$rel_path
new file mode 100644
index 0000000..0000000
--- /dev/null
+++ b/$rel_path
$(cat "$file" 2>/dev/null | sed 's/^/+/')"
  done < <(find "$dir" -type f \
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
    -print0 2>/dev/null)

  echo "$diff_output"
}

IS_GIT_REPO=false
if git rev-parse --git-dir >/dev/null 2>&1; then
  IS_GIT_REPO=true
fi

# 現在のディレクトリ名が除外対象の場合はスキップ（非 Git の場合のみ）
if [ "$IS_GIT_REPO" = false ]; then
  current_dir_name=$(basename "$(pwd)")
  if echo "$current_dir_name" | grep -qE "^(\.claude|\.git|node_modules|dist|build|vendor|__pycache__|\.venv|coverage|\.next|\.nuxt|\.cache|\.turbo)$"; then
    echo "Info: Skipping excluded directory: $current_dir_name" >&2
    exit 0
  fi
fi

DIFF_CONTENT=""

if [ "$IS_GIT_REPO" = true ]; then
  # ===== Git リポジトリ: ブランチベースレビュー =====
  # base ブランチを検出（main, master, develop など）
  base_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
  if [ -z "$base_branch" ]; then
    # フォールバック: よくある base ブランチ名を試す
    for candidate in main master develop; do
      if git show-ref --verify --quiet refs/remotes/origin/${candidate}; then
        base_branch="$candidate"
        break
      fi
    done
  fi

  # ブランチが base から分岐している場合、ブランチ全体の変更をレビュー
  if [ -n "$base_branch" ] && git merge-base --is-ancestor origin/${base_branch} HEAD 2>/dev/null; then
    current_branch=$(git branch --show-current 2>/dev/null)

    # base ブランチで直接作業していない場合のみブランチベースレビュー
    if [ -n "$current_branch" ] && [ "$current_branch" != "$base_branch" ]; then
      branch_diff=$(git diff origin/${base_branch}...HEAD 2>/dev/null)

      # ブランチに実際にコミットがある場合のみブランチベースレビュー
      if [ -n "$branch_diff" ]; then
        echo "Info: Branch-based review (${base_branch}...${current_branch})" >&2
        DIFF_CONTENT="$branch_diff"
      fi
    fi
  fi

  # フォールバック: base ブランチで作業中、ブランチにコミットがない、または検出できない場合は HEAD との差分
  if [ -z "$DIFF_CONTENT" ]; then
    echo "Info: Working tree review (diff HEAD)" >&2
    DIFF_CONTENT=$(git diff HEAD 2>/dev/null)
  fi

  # untracked ファイルも diff に含める（新規作成ファイルのレビュー）
  untracked_files=$(git ls-files --others --exclude-standard 2>/dev/null)
  if [ -n "$untracked_files" ]; then
    while IFS= read -r file; do
      if [ -f "$file" ]; then
        # サイズチェック
        file_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo 0)
        if [ "$file_size" -gt "$MAX_FILE_SIZE" ]; then
          continue
        fi
        # バイナリチェック
        if is_binary_file "$file"; then
          continue
        fi
        # untracked ファイルを diff 形式で追加
        DIFF_CONTENT="${DIFF_CONTENT}
diff --git a/$file b/$file
new file mode 100644
index 0000000..0000000
--- /dev/null
+++ b/$file
$(cat "$file" 2>/dev/null | sed 's/^/+/')"
      fi
    done <<< "$untracked_files"
  fi
else
  # ===== 非 Git: ディレクトリ全体をレビュー =====
  echo "Info: Non-Git directory review (scanning all files)" >&2
  DIFF_CONTENT=$(generate_directory_diff "$(pwd)")
fi

# 差分がない場合はスキップ
if [ -z "$DIFF_CONTENT" ]; then
  exit 0
fi

# /clear や /compact コマンドの場合はスキップ
if echo "$DIFF_CONTENT" | grep -qE '^\+.*(^|[^a-zA-Z0-9])(/clear|/compact)([^a-zA-Z0-9]|$)'; then
  echo "Skipping code review for /clear or /compact command" >&2
  exit 0
fi

# 現在のディレクトリのフルパスを取得（キャッシュ用）
project_path=$(pwd)
cache_dir="$HOME/.claude/cache/code-review"
mkdir -p "$cache_dir"

# プロジェクトごとのキャッシュファイル
safe_project_name="${project_path//[^a-zA-Z0-9]/_}"
cache_file="$cache_dir/${safe_project_name}.cache"

# diff のハッシュ値を計算
diff_hash=$(echo "$DIFF_CONTENT" | shasum -a 256 | cut -d' ' -f1)

# キャッシュチェック（ハッシュのみ）
if [ -f "$cache_file" ]; then
  last_hash=$(cat "$cache_file" 2>/dev/null)

  # 前回と同じ diff の場合はスキップ
  if [ "$diff_hash" = "$last_hash" ]; then
    echo "Skipping: diff unchanged from last review" >&2
    exit 0
  fi
fi

# キャッシュの更新は save_review_result で実行（レビュー成功後）

# 必要なコマンドの確認
CODEX_AVAILABLE=false
CLAUDE_AVAILABLE=false

if command -v codex >/dev/null 2>&1; then
  CODEX_AVAILABLE=true
fi

if command -v claude >/dev/null 2>&1; then
  CLAUDE_AVAILABLE=true
fi

if [ "$CODEX_AVAILABLE" = false ] && [ "$CLAUDE_AVAILABLE" = false ]; then
  echo "Error: neither codex nor claude command found" >&2
  exit 1
fi

# API Keys の取得（~/.env から読み込み、環境変数でオーバーライド可能）
if [ -f "$HOME/.env" ]; then
  DEVIN_API_KEY=$(grep '^DEVIN_API_KEY=' "$HOME/.env" | cut -d '=' -f2- | sed -e 's/^"//' -e 's/"$//' -e "s/^'//" -e "s/'$//")
fi

# 環境変数が設定されている場合は、それを優先
DEVIN_API_KEY="${DEVIN_API_KEY:-}"

# MCP 統合状況を報告
if [ -n "$DEVIN_API_KEY" ]; then
  echo "Info: Devin MCP enabled (private repo support)" >&2
else
  echo "Warning: DEVIN_API_KEY not found, Devin MCP unavailable" >&2
fi

echo "Info: DeepWiki MCP enabled (public repo documentation)" >&2

# Claude モデルの設定
CLAUDE_MODEL="claude-haiku-4-5-20251001"
echo "Info: Claude model: $CLAUDE_MODEL" >&2

# JSON ファイルに保存（project_path は上部で定義済み）
score_file="$HOME/.claude/code_review_scores.json"

# MCP 設定の JSON を構築（Claude 用）
build_mcp_config() {
  if [ -n "$DEVIN_API_KEY" ]; then
    cat <<EOF
{
  "mcpServers": {
    "devin": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.devin.ai/sse", "--header", "Authorization:Bearer $DEVIN_API_KEY"]
    },
    "deepwiki": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.deepwiki.com/sse"]
    }
  }
}
EOF
  else
    cat <<EOF
{
  "mcpServers": {
    "deepwiki": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.deepwiki.com/sse"]
    }
  }
}
EOF
  fi
}

# コードレビュープロンプトの作成（共通）
# 引数: $1 = diff 内容
create_review_prompt() {
  local diff_content="$1"
  cat <<EOF
あなたは経験豊富なソフトウェアエンジニアとしてコードレビューを行います。

## コンテキスト取得プロトコル

1. **一次情報の優先確認**
   - 提供された diff、変更対象ファイルの前後文脈、既存テスト、ローカルの AGENTS.md/docs/README などリポジトリ内ドキュメントを最優先で確認してください。

2. **型定義や実装の確認には MCP を積極利用**
   - 未知の型・クラス・メソッド・プロパティが出現した場合、まず MCP で確認してください。
   - 利用可能な MCP サーバーを確認し、devin (プライベート向け) と deepwiki (公開向け) を使い分けます。
   - 特に以下の場合は MCP による確認を推奨：
     * プロジェクト固有の型やクラス
     * フレームワーク固有の実装やビジネスロジック

3. **MCP での情報収集（型・実装確認時は必須）**
   - **未知の型が現れたら必ず実行**:
     * ask_question で「この型の定義を教えてください」
     * ask_question で「このプロパティは存在しますか？」
   - **ドキュメント確認手順**:
     * read_wiki_structure: 関連しそうなトピックを確認
     * read_wiki_contents: 該当ドキュメントを取得し、ローカル資料と突き合わせ
     * ask_question: 具体的な疑問を投げて補完情報を得る
   - Devin から情報が得られない場合のみ DeepWiki で公開情報を補完してください。

4. **情報源の記録**
   - MCP から得た内容を判断根拠に使った場合は、 (Devin: auth.md) 、 (DeepWiki: README.md) のようにファイル名のみで出典を findings/comment に必ず記載してください。
   - 情報取得に失敗した場合は findings に「情報不足」と明記し、confidence_score ≤ 0.5 としてください。

## 重要な前提条件

- diff・既存コード・テスト・AGENTS.md を最優先で検証し、MCP は補助的に利用してください。
- 標準ライブラリに存在しない型・メソッド・プロパティが現れた場合は、積極的に MCP で確認してください。
- 裏付けが取れない指摘は confidence_score ≤ 0.7。Devin/DeepWiki で根拠を取得できた場合のみ 0.8 以上を付けてください。
- プロジェクト固有の拡張は、型定義やドキュメントで確認してから評価してください。
- 取得できなかった情報が判断に影響する場合は findings に明記してください。

以下の git diff を詳細にレビューし、Google・Microsoft のコードレビューガイドラインに基づいて各評価項目を採点してください。
各項目 0-12.5 点満点で、総合スコアは 8 項目の合計（100 点満点）です。

## 評価項目と採点基準

1. **機能性 (functionality)** - 12.5 点満点
   - 12.5 点: 要求を完全に満たし、バグなし、エッジケースにも対応
   - 8 点: 基本機能は動作、軽微な問題あり
   - 4 点: 部分的に動作、重要な問題あり
   - 0 点: 動作しない、重大なバグ

2. **コード品質 (code_quality)** - 12.5 点満点
   - 12.5 点: 高い可読性・保守性、適切な抽象化、DRY 原則遵守
   - 8 点: 概ね良好、軽微な改善点あり
   - 4 点: 理解困難、重複コードあり
   - 0 点: 非常に悪い品質、保守困難

3. **設計 (design)** - 12.5 点満点
   - 12.5 点: アーキテクチャに完全適合、適切な設計パターン使用
   - 8 点: 概ね適切、軽微な設計上の問題
   - 4 点: 設計に懸念、将来の拡張性に問題
   - 0 点: 設計が破綻、全体構造に悪影響

4. **テスト (testing)** - 12.5 点満点
   - 12.5 点: 十分なカバレッジと質の高いテスト（テスト不要な変更でも満点可）
   - 8 点: 基本的なテストあり、カバレッジ不足
   - 4 点: 最小限のテスト、品質に問題
   - 0 点: 必要なテストが欠如

5. **セキュリティ (security)** - 12.5 点満点
   - 12.5 点: セキュリティ問題なし、ベストプラクティス遵守
   - 8 点: 軽微な改善点あり
   - 4 点: 中程度のリスク存在
   - 0 点: 深刻な脆弱性

6. **パフォーマンス (performance)** - 12.5 点満点
   - 12.5 点: 実行効率・メモリ使用が最適
   - 8 点: 概ね良好、軽微な最適化余地
   - 4 点: 性能上の懸念あり
   - 0 点: 深刻な性能問題

7. **命名とコメント (naming_comments)** - 12.5 点満点
   - 12.5 点: 意図が明確な命名、適切なコメント/ドキュメント
   - 8 点: 概ね良好、改善余地あり
   - 4 点: 不明瞭な命名、コメント不足
   - 0 点: 非常に悪い命名、コメントなし

8. **コーディング規約 (coding_standards)** - 12.5 点満点
   - 12.5 点: スタイルガイド完全遵守、一貫性あり
   - 8 点: 概ね遵守、軽微な違反
   - 4 点: 多くの違反
   - 0 点: 規約無視、一貫性なし

## 優先度レベル

- **P0**: ブロッキング問題、即修正
- **P1**: 緊急、次サイクルで対応
- **P2**: 通常優先度
- **P3**: 低優先度、改善推奨

**重要: 以下の JSON フォーマットのみを返してください。説明文やマークダウンは不要です。**

{
  "score": 総合点（0-100 の数値）,
  "functionality": 機能性の点数（0-12.5 の数値）,
  "code_quality": コード品質の点数（0-12.5 の数値）,
  "design": 設計の点数（0-12.5 の数値）,
  "testing": テストの点数（0-12.5 の数値）,
  "security": セキュリティの点数（0-12.5 の数値）,
  "performance": パフォーマンスの点数（0-12.5 の数値）,
  "naming_comments": 命名とコメントの点数（0-12.5 の数値）,
  "coding_standards": コーディング規約の点数（0-12.5 の数値）,
  "comment": "日本語で主な改善点や良い点の簡潔な説明（3-4 文の文字列）",
  "devin_insights": {
    "security_issues": "Devin で得た知見。利用しなかった場合は \"N/A\"",
    "performance_insights": "Devin で得た知見。利用しなかった場合は \"N/A\"",
    "best_practices": "Devin で得た知見。利用しなかった場合は \"N/A\""
  },
  "findings": [
    {
      "title": "問題の簡潔な説明",
      "body": "問題の詳細説明",
      "confidence_score": 確信度（0.0-1.0 の数値）,
      "priority": 優先度（0-3 の整数、P0=0, P1=1, P2=2, P3=3）,
      "source": "検出ソース（\"codex\" / \"claude\" / \"Devin\" / \"DeepWiki\"）",
      "code_location": {
        "file_path": "ファイルパス",
        "line_range": {"start": 開始行番号, "end": 終了行番号}
      }
    }
  ]
}

---

**レビュー対象の git diff:**

\`\`\`diff
$diff_content
\`\`\`

**重要：**

- JSON の各項目は必ず対応する数値・文字列型を守ってください。
- comment と各 finding には、利用した情報源（例: (AGENTS.md: セクション 3) 、 (Devin: docs/auth.md) 、 (DeepWiki: README)）を括弧書きで明記してください。
- findings は最大 5 件まで。情報不足の場合はその旨を記し、confidence_score ≤ 0.5。
- Devin が利用できない場合でも、ローカル情報に基づくレビューを完遂してください。
EOF
}

# Codex でレビューを実行
run_codex_review() {
  local temp_file
  temp_file=$(mktemp)
  local prompt_file
  prompt_file=$(mktemp)

  # プロンプトを直接ファイルに保存（stdout 漏れ防止のためコマンド置換を使わない）
  create_review_prompt "$DIFF_CONTENT" > "$prompt_file"

  # stderr をログに記録（認証エラー等のトラブルシューティングのため）
  if [ -n "$DEVIN_API_KEY" ]; then
    timeout 300 codex exec \
      --sandbox read-only \
      --skip-git-repo-check \
      --color never \
      --json \
      --output-last-message "$temp_file" \
      -c 'mcp_servers.devin.command="npx"' \
      -c "mcp_servers.devin.args=[\"-y\",\"mcp-remote\",\"https://mcp.devin.ai/sse\",\"--header\",\"Authorization:Bearer $DEVIN_API_KEY\"]" \
      -c 'mcp_servers.deepwiki.command="npx"' \
      -c 'mcp_servers.deepwiki.args=["-y","mcp-remote","https://mcp.deepwiki.com/sse"]' \
      < "$prompt_file" >/dev/null
  else
    timeout 300 codex exec \
      --sandbox read-only \
      --skip-git-repo-check \
      --color never \
      --json \
      --output-last-message "$temp_file" \
      -c 'mcp_servers.deepwiki.command="npx"' \
      -c 'mcp_servers.deepwiki.args=["-y","mcp-remote","https://mcp.deepwiki.com/sse"]' \
      < "$prompt_file" >/dev/null
  fi

  rm -f "$prompt_file"

  if [ -f "$temp_file" ] && [ -s "$temp_file" ]; then
    local evaluation
    evaluation=$(cat "$temp_file")
    save_review_result "codex" "$evaluation"
  else
    echo "Error: Codex review failed or produced no output" >&2
  fi

  rm -f "$temp_file"
}

# Claude でレビューを実行
run_claude_review() {
  local prompt_file
  prompt_file=$(mktemp)

  # プロンプトを直接ファイルに保存（stdout 漏れ防止のためコマンド置換を使わない）
  create_review_prompt "$DIFF_CONTENT" > "$prompt_file"

  local mcp_config
  mcp_config=$(build_mcp_config | jq -c .)

  local temp_file
  temp_file=$(mktemp)

  # stdout を一時ファイルにリダイレクトして完全に隔離
  # stderr をログに記録（認証エラー等のトラブルシューティングのため）
  # --settings '{"hooks":{}}' で Stop hook を無効化（無限ループ防止）
  timeout 300 claude -p \
    --model "$CLAUDE_MODEL" \
    --output-format json \
    --mcp-config "$mcp_config" \
    --allowedTools "Read Glob Grep" \
    --settings '{"hooks":{}}' \
    < "$prompt_file" >"$temp_file"

  rm -f "$prompt_file"

  if [ -s "$temp_file" ]; then
    local result
    result=$(cat "$temp_file")

    # Claude の JSON 出力から .result フィールドを抽出
    local evaluation
    evaluation=$(echo "$result" | jq -r '.result' 2>/dev/null)
    if [ -n "$evaluation" ] && [ "$evaluation" != "null" ]; then
      # evaluation が JSON 文字列の場合は、そのままパース
      if echo "$evaluation" | jq . >/dev/null 2>&1; then
        save_review_result "claude" "$evaluation"
      else
        # マークダウンのコードブロックから JSON を抽出
        local json_content
        # shellcheck disable=SC2016
        json_content=$(echo "$evaluation" | sed -n '/^```json$/,/^```$/p' | sed '1d;$d')
        if [ -n "$json_content" ] && echo "$json_content" | jq . >/dev/null 2>&1; then
          save_review_result "claude" "$json_content"
        else
          echo "Error: Claude review result is not valid JSON" >&2
        fi
      fi
    else
      echo "Error: Claude review failed to extract result" >&2
    fi
  else
    echo "Error: Claude review failed or produced no output" >&2
  fi

  rm -f "$temp_file"
}

# 1週間以上更新がないレコードを削除
cleanup_old_reviews() {
  local score_file="$1"

  if [ ! -f "$score_file" ]; then
    return 0
  fi

  if ! command -v jq >/dev/null 2>&1; then
    return 0
  fi

  # 現在時刻（Unix timestamp）
  local now
  now=$(date +%s)

  # 7日前のタイムスタンプ（秒）
  local seven_days_ago=$((now - 7 * 24 * 60 * 60))

  # 一時ファイル
  local temp_file="${score_file}.cleanup.tmp"

  # クリーンアップ前のレコード数
  local before_count
  before_count=$(jq 'keys | length' "$score_file" 2>/dev/null || echo 0)

  # 各プロジェクトをチェックして、7日以内に更新されたものだけ残す
  jq --argjson cutoff "$seven_days_ago" '
    to_entries | map(
      select(
        (.value.codex.timestamp // .value.claude.timestamp) as $ts |
        if $ts then
          ($ts | fromdateiso8601) > $cutoff
        else
          false
        end
      )
    ) | from_entries
  ' "$score_file" > "$temp_file" 2>/dev/null

  if [ $? -eq 0 ] && [ -s "$temp_file" ]; then
    local after_count
    after_count=$(jq 'keys | length' "$temp_file" 2>/dev/null || echo 0)
    local deleted_count=$((before_count - after_count))

    if [ "$deleted_count" -gt 0 ]; then
      echo "Info: Cleaned up $deleted_count old review(s) (older than 7 days)" >&2
    fi

    mv "$temp_file" "$score_file"
  else
    rm -f "$temp_file"
  fi
}

# レビュー結果を JSON に保存
save_review_result() {
  local engine=$1
  local evaluation=$2

  # JSON から各スコアを抽出
  local score
  score=$(echo "$evaluation" | jq -r '.score // 0')
  local functionality
  functionality=$(echo "$evaluation" | jq -r '.functionality // 0')
  local code_quality
  code_quality=$(echo "$evaluation" | jq -r '.code_quality // 0')
  local design
  design=$(echo "$evaluation" | jq -r '.design // 0')
  local testing
  testing=$(echo "$evaluation" | jq -r '.testing // 0')
  local security
  security=$(echo "$evaluation" | jq -r '.security // 0')
  local performance
  performance=$(echo "$evaluation" | jq -r '.performance // 0')
  local naming_comments
  naming_comments=$(echo "$evaluation" | jq -r '.naming_comments // 0')
  local standards
  standards=$(echo "$evaluation" | jq -r '.coding_standards // 0')
  local comment
  comment=$(echo "$evaluation" | jq -r '.comment // "コメントなし"')
  local devin_insights
  devin_insights=$(echo "$evaluation" | jq '.devin_insights // {}')

  # エンジンごとのレビューデータを作成
  local engine_data
  local model_info="null"
  if [ "$engine" = "claude" ]; then
    model_info="\"$CLAUDE_MODEL\""
  fi

  engine_data=$(
    cat <<EOF
{
  "score": $score,
  "max_score": 100,
  "evaluation_method": "$engine",
  "model": $model_info,
  "devin_enabled": $([ -n "$DEVIN_API_KEY" ] && echo "true" || echo "false"),
  "details": {
    "functionality": $functionality,
    "code_quality": $code_quality,
    "design": $design,
    "testing": $testing,
    "security": $security,
    "performance": $performance,
    "naming_comments": $naming_comments,
    "coding_standards": $standards,
    "comment": $(echo "$comment" | jq -R .),
    "devin_insights": $devin_insights
  },
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "project_path": "$project_path"
}
EOF
  )

  # jq を使用してプロジェクトとエンジンごとに保存
  if command -v jq >/dev/null 2>&1; then
    local lock_dir="${score_file}.lock"
    local max_wait=10
    local waited=0

    # mkdir を使った atomic なロック取得（macOS 互換）
    while ! mkdir "$lock_dir" 2>/dev/null; do
      sleep 0.1
      waited=$((waited + 1))
      if [ $waited -gt $((max_wait * 10)) ]; then
        echo "Error: Failed to acquire lock after ${max_wait}s" >&2
        return 1
      fi
    done

    # ロック取得後の処理
    if [ -f "$score_file" ]; then
      jq --argjson new "$engine_data" --arg proj "$project_path" --arg eng "$engine" \
        '.[$proj][$eng] = $new' "$score_file" >"${score_file}.tmp" &&
        mv "${score_file}.tmp" "$score_file"
    else
      echo "$engine_data" | jq --arg proj "$project_path" --arg eng "$engine" \
        '{($proj): {($eng): .}}' >"$score_file"
    fi

    # 1週間以上古いレコードをクリーンアップ（ロック内で実行）
    cleanup_old_reviews "$score_file"

    # ロック解放
    rmdir "$lock_dir" 2>/dev/null
  else
    # jq がない場合は個別ファイルとして保存
    local safe_filename
    safe_filename=$(echo "$project_path" | sed 's/\\//_/g')
    local individual_score_file="$HOME/.claude/code_review_score_${engine}${safe_filename}.json"
    echo "$engine_data" >"$individual_score_file"
  fi

  # レビュー成功後にキャッシュを更新
  echo "$diff_hash" > "$cache_file"

  # デバッグログ（background モードの場合）
  if [ "$REVIEW_MODE" = "background" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') Review saved: $engine score=$score project=$project_path" >&2
  fi
}

# メイン実行
main() {
  printf "%bStarting dual code review (Codex + Claude) in background...%b\n" "$WHITE" "$RESET" >&2

  if [ "$CODEX_AVAILABLE" = true ]; then
    (run_codex_review) &
  fi

  # TODO: Claude レビュー一時無効化（手動で戻すこと）
  # if [ "$CLAUDE_AVAILABLE" = true ]; then
  #   (run_claude_review) &
  # fi

  # バックグラウンドで実行するため、即座に終了
  printf "%bCode review with Codex and Claude started in background%b\n" "$WHITE" "$RESET" >&2
  exit 0
}

# background/direct モードで main 関数を実行
# hook モードは既にスクリプトの最初で処理済み
main
