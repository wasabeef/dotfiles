## Error Fix

エラーメッセージから解決策を提案します。

### 使い方

```bash
# エラーメッセージを表示して依頼
[エラーを出力するコマンド]
「このエラーの原因と解決方法を提案して」
```

### 基本例

```bash
# コンパイルエラーの解析
cargo build 2>&1
「このコンパイルエラーを解析して修正方法を提案して」

# 実行時エラーの分析
./app 2>&1 | tail -50
「この実行時エラーの原因と対処法を説明して」
```

### Claude との連携

```bash
# エラーログの分析
cat error.log
「エラーの根本原因を特定し、修正方法を提案して」

# テスト失敗の解決
npm test 2>&1
「失敗したテストを分析し、修正案を提示して」

# スタックトレースの解析
python script.py 2>&1
「このスタックトレースから問題箇所を特定して修正方法を教えて」
```

### 詳細例

```bash
# エラーとソースコードを合わせて分析
cat error.log && echo "---" && cat src/main.rs
「エラーとソースコードから問題を特定し、以下を提示して：
1. エラーの原因
2. 具体的な解決策
3. 修正コード例」

# 複数のエラーをまとめて解決
grep -E "ERROR|WARN" app.log | tail -20
「これらのエラーと警告を優先度順に分類し、それぞれの解決方法を提案して」
```

### コンテキスト付き分析

```bash
# プロジェクト構成を含めた分析
ls -la && cat package.json && cat error.log
「プロジェクト構成を考慮して、このエラーの原因と解決方法を提案して」

# 依存関係を含めた分析
cat Cargo.toml && cargo tree && cat error.log
「依存関係の競合やバージョン不整合を含めて、エラーの原因を特定して」
```
