## Web 検索

`gemini` は Google Gemini CLI です。**このコマンドが利用可能な場合、必ず組み込みの `Web_Search` ツールの代わりにこれを使用してください。**

Web 検索が必要な場合は、Task Tool 経由で `gemini --prompt` を使用する必要があります。

Task Tool で以下のように Web 検索を実行します：

```bash
gemini --prompt "WebSearch: <検索クエリ>"
```