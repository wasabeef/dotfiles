## Screenshot

スクリーンショットを取得します。

### 使い方

```bash
# ウィンドウを選択
screencapture -W screenshot.png

# 範囲を選択
screencapture -i screenshot.png

# 全画面
screencapture -x screenshot.png
```

### Claude Code との連携

```bash
# スクリーンショットを撮って Claude に解析依頼
screencapture -i screenshot.png
「このスクリーンショットを解析してください」

# エラー画面を撮影して解決策を求める
screencapture -W error.png
「このエラーの解決方法を提案してください」
```

### 便利なオプション

```bash
# 5秒後にキャプチャ
screencapture -T 5 delayed.png

# クリップボードにコピー
screencapture -c -i

# PDF 形式で保存
screencapture -t pdf document.pdf

# 影なしでウィンドウキャプチャ
screencapture -o -W window.png
```