## Rust Dependencies Update

Cargo.toml の依存関係を安全に最新化し、変更点を分析してコード更新を支援します。

### 使い方

```bash
# 1. 現在の依存関係を確認
cat Cargo.toml
cargo tree

# 2. Claude に依頼
「Cargo.toml の依存関係を最新化して。Release Notes や CHANGELOG から破壊的変更を特定し、必要なコード修正も提案して」
```

### 更新の実行

```bash
# バックアップ作成と更新
cp Cargo.toml Cargo.toml.backup
cargo update
cargo tree

# 段階的更新（安全）
cargo update
cargo test
```

### 依頼文の例

```
「Cargo.toml の依存関係を分析し、以下を実行してください：

1. 各クレートの最新バージョンを調査
2. Release Notes や CHANGELOG から破壊的変更を特定
3. 危険度を評価（安全・注意・危険）
4. 必要なコード変更を具体的に提案
5. 更新版 Cargo.toml を生成

重点確認項目：
- API の変更
- 非推奨機能の削除
- 新しい必須パラメータ
- トレイト境界の変更
- マクロの変更」
```

### 危険度分析の観点

```
🟢 安全（Green）：
- パッチバージョンアップ（bug fix のみ）
- 後方互換性が保証されている
- Release Notes や CHANGELOG に破壊的変更の記載なし

🟡 注意（Yellow）：
- マイナーバージョンアップ
- 新機能追加があるが後方互換
- 非推奨警告があるが動作する

🔴 危険（Red）：
- メジャーバージョンアップ
- 破壊的変更あり
- API の削除や変更
- 必須パラメータの追加
- トレイト境界の変更
```

### 自動コード修正の例

```rust
// 例：serde パッケージの更新
// 旧バージョン（serde 1.0.100）
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize)]
struct User {
    name: String,
    age: u32,
}

// 新バージョン（serde 1.0.150）で新機能使用
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize)]
#[serde(deny_unknown_fields)] // 新しいアトリビュート
struct User {
    name: String,
    age: u32,
}
```

### 更新後の確認

```bash
cargo check
cargo test
cargo clippy
```

### 緊急時の復元

```bash
# 問題が発生した場合
cp Cargo.toml.backup Cargo.toml
cargo build
```