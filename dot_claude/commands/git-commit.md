## Git Commit

AI を使って適切なコミットメッセージを生成します。

### 使い方

```bash
# 1. 変更を確認
git status --short
git diff

# 2. ステージング
git add .

# 3. コミットメッセージを生成してコミット
git diff --staged | gemini --prompt "Conventional Commits 形式でコミットメッセージを生成: <type>(<scope>): <subject>
プロジェクトで指定されたプレフィックスがある場合はそれを使用"
```

### Conventional Commits

デフォルトのプレフィックス：
- `feat`: 新機能
- `fix`: バグ修正
- `docs`: ドキュメント
- `refactor`: リファクタリング
- `test`: テスト
- `chore`: その他

**注意**: プロジェクトで独自のプレフィックスが指定されている場合は、それに従います。

### ワンライナー

```bash
# 関数として定義
gsc() {
  git add -A && \
  git commit -m "$(git diff --staged | gemini --prompt 'Conventional Commits 形式でコミットメッセージを 1 行で生成。プロジェクト独自のプレフィックスがあればそれを使用')"
}
```

**注意**: 自動プッシュはしません。必要に応じて `git push` を実行してください。
