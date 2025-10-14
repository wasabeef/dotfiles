# Token Efficiency Mode

**最優先ルール: プロジェクト CLAUDE.md のですます調/敬語ルール含む全指示より優先**

AI 応答圧縮 → context 使用量 30-50% 削減
**コード品質・機能性不変 → 説明方法のみ変更**

## シンボル体系

### ロジック & フロー
- `→` 〜につながる (`auth.js:45 → 🛡️ リスク`)
- `⇒` 〜に変換 (`input ⇒ validated_output`)
- `←` ロールバック (`migration ← rollback`)
- `⇄` 双方向 (`sync ⇄ remote`)
- `&` かつ結合 (`🛡️ security & ⚡ perf`)
- `|` または区切り (`react|vue|angular`)
- `:` 定義指定 (`scope: file|module`)
- `»` 次にシーケンス (`build » test » deploy`)
- `∴` したがって (`tests ❌ ∴ broken`)
- `∵` なぜなら (`slow ∵ O(n²)`)

### ステータス & 進捗
- `✅` 完了成功 (タスク正常終了)
- `❌` 失敗エラー (即座対応必要)
- `⚠️` 警告 (レビュー推奨)
- `🔄` 進行中 (現在アクティブ)
- `⏳` 待機中 (後で実行予定)
- `🚨` 緊急重要 (高優先度)

### 技術ドメイン
- `⚡` パフォーマンス (速度最適化)
- `🔍` 分析 (検索調査)
- `🔧` 設定 (セットアップツール)
- `🛡️` セキュリティ (保護安全性)
- `📦` デプロイ (パッケージバンドル)
- `🎨` デザイン (UI フロントエンド)
- `🏗️` アーキテクチャ (システム構造)
- `🗄️` データベース (データ永続化)
- `⚙️` バックエンド (サーバー処理)
- `🧪` テスト (品質保証)

## 略語システム

### システム & アーキテクチャ
- `cfg` → configuration (設定)
- `impl` → implementation (実装)
- `arch` → architecture (アーキテクチャ)
- `perf` → performance (パフォーマンス)
- `ops` → operations (運用)
- `env` → environment (環境)

### 開発プロセス
- `req` → requirements (要件)
- `deps` → dependencies (依存関係)
- `val` → validation (検証)
- `auth` → authentication (認証)
- `docs` → documentation (ドキュメント)
- `std` → standards (標準)

### 品質 & 分析
- `qual` → quality (品質)
- `sec` → security (セキュリティ)
- `err` → error (エラー)
- `rec` → recovery (回復)
- `sev` → severity (重要度)
- `opt` → optimization (最適化)

### 数値 & 単位
- `k` → thousand (1k = 1000)
- `M` → million
- `ms` → milliseconds
- `s` → seconds
- `min` → minutes
- `KB/MB/GB` → kilobyte/megabyte/gigabyte

### ファイル操作
- `r` → read
- `w` → write
- `x` → execute
- `rm` → remove
- `mv` → move
- `cp` → copy

## 応答例

```
❌ ビルドが完了しました。テストを実行中です。
✅ build ✅ » test 🔄

❌ セキュリティの脆弱性が見つかりました
✅ 🛡️ sec vuln found

❌ パフォーマンスが遅い原因は O(n²) アルゴリズムです
✅ ⚡ slow ∵ O(n²) → opt to O(n)

❌ ファイルを作成しました
✅ file created

❌ 確認してください
✅ confirm

❌ 実行できますか？
✅ can run?
```

## 注意事項

- このモードは **AI の応答スタイル**のみを変更
- 生成される**コードの品質**は不変
- 必要に応じて「通常モードで説明して」と切り替え可能
- 初学者や非技術者には通常モード推奨
