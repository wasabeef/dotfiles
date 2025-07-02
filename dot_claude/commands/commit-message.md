## Commit Message

ステージングされた変更（git diff --staged）から適切なコミットメッセージを生成します。実際のコミットは行わず、メッセージの提案のみを行います。

### 使い方

```bash
/commit-message [オプション]
```

### オプション

- `--format <形式>` : メッセージ形式を指定（conventional, gitmoji, angular）
- `--lang <言語>` : メッセージ言語を強制指定（en, ja）
- `--breaking` : Breaking Change の検出と記載

### 基本例

```bash
# 1. 変更をステージング
git add <files>

# 2. ステージングされた変更からメッセージ生成（言語自動判定）
# メイン候補が自動的にクリップボードにコピーされます
/commit-message

# 3. 言語を強制的に指定
/commit-message --lang ja
/commit-message --lang en

# 4. Breaking Change を検出
/commit-message --breaking
```

### 前提条件

**重要**: このコマンドは `git add` でステージングされた変更のみを分析します。変更をステージングしてから実行してください。

```bash
# 変更をステージングしてから実行
git add .
/commit-message
```

### 自動クリップボード機能

生成されたメイン候補のコミットメッセージは自動的に `pbcopy` でクリップボードにコピーされます。すぐに `git commit -m` で貼り付けて使用できます。

### 言語の自動判定

以下の条件で自動的に日本語/英語を切り替えます：

1. **過去のコミット履歴**をチェック
2. **README** や **ドキュメント**の言語を確認
3. **コメント**の言語を分析

デフォルトは英語。日本語プロジェクトと判定された場合は日本語で生成。

### メッセージ形式

#### Conventional Commits (デフォルト)

```
<type>: <description>
```

**注意**: プロジェクト独自の規約がある場合は、それを優先します。

### 標準プレフィックス

- `feat`: 新機能
- `fix`: バグ修正
- `docs`: ドキュメントのみの変更
- `style`: コードの意味に影響しない変更
- `refactor`: バグ修正や機能追加を伴わないコード変更
- `perf`: パフォーマンス改善
- `test`: テストの追加・修正
- `chore`: ビルドプロセスやツールの変更

### 出力例（英語プロジェクト）

```bash
$ /commit-message

📝 コミットメッセージ提案
━━━━━━━━━━━━━━━━━━━━━━━━━

✨ メイン候補:
feat: implement JWT-based authentication system

📋 代替案:
1. feat: add user authentication with JWT tokens
2. fix: resolve token validation error in auth middleware
3. refactor: extract auth logic into separate module

✅ "feat: implement JWT-based authentication system" をクリップボードにコピーしました
```

### 出力例（日本語プロジェクト）

```bash
$ /commit-message

📝 コミットメッセージ提案
━━━━━━━━━━━━━━━━━━━━━━━━━

✨ メイン候補:
feat: JWT 認証システムを実装

📋 代替案:
1. feat: JWT トークンによるユーザー認証を追加
2. fix: 認証ミドルウェアのトークン検証エラーを解決
3. docs: 認証ロジックを別モジュールに分離

✅ "機能: JWT 認証システムを実装" をクリップボードにコピーしました
```

### 使用方法

```bash
# 1. コミットメッセージ生成（自動でクリップボードへ）
/commit-message

# 2. そのままペーストしてコミット
git commit -m "Cmd+V でペースト"
```

### スマート機能

#### 1. 変更内容の自動分類（ステージングされたファイルのみ）

- 新ファイル追加 → `feat`
- エラー修正パターン → `fix`
- テストファイルのみ → `test`
- 設定ファイル変更 → `chore`
- README/docs 更新 → `docs`

#### 2. プロジェクト規約の自動検出

- `.gitmessage` ファイル
- `CONTRIBUTING.md` 内の規約
- 過去のコミット履歴パターン

#### 3. 言語判定の詳細（ステージングされた変更のみ）

```bash
# 判定基準（優先順位）
1. git diff --staged の内容から言語を判定
2. ステージングされたファイルのコメント分析
3. git log --oneline -20 の言語分析
4. プロジェクトのメイン言語設定
```

#### 4. ステージング分析の詳細

```bash
# 以下のコマンドの結果を分析
git diff --staged --name-only    # 変更ファイル一覧
git diff --staged                # 実際の変更内容
git status --porcelain           # ファイル状態
```

### Breaking Change 検出時

**英語**:

```bash
feat: [BREAKING CHANGES] change API response format for user endpoints
```

**日本語**:

```bash
feat: [BREAKING CHANGES] ユーザーエンドポイントの API レスポンス形式を変更
```

### ベストプラクティス

1. **プロジェクトに合わせる**: 既存のコミット言語に従う
2. **簡潔性**: 50 文字以内で明確に
3. **一貫性**: 混在させない（英語なら英語で統一）
4. **OSS**: オープンソースなら英語推奨

### よくあるパターン

**英語**:

```
feat: add user registration endpoint
fix: resolve memory leak in cache manager
docs: update API documentation
```

**日本語**:

```
feat: ユーザー登録エンドポイントを追加
fix: キャッシュマネージャーのメモリリークを解決
docs: API ドキュメントを更新
```
