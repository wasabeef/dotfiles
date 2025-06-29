## Context7 検索

MCP の context7 を使って関連ドキュメントを検索します。

### 使い方

Claude Code で context7 を使うには、会話の中で以下のように依頼します：

```
「context7 で React hooks について検索して」
「context7 でエラーハンドリングの情報を探して」
```

### フォールバック

context7 で情報が見つからない場合：

```bash
# Web 検索を使用
gemini --prompt "WebSearch: <検索クエリ>"
```

### 活用例

1. **技術調査**
   ```
   「context7 で Rust の所有権システムについて調べて」
   ```

2. **エラー解決**
   ```
   「context7 で Rust の borrow checker エラーの解決方法を検索」
   ```

3. **ベストプラクティス**
   ```
   「context7 で Rust のエラーハンドリングのベストプラクティスを探して」
   ```
