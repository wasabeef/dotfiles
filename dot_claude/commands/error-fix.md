## Error Fix

エラーメッセージから解決策を提案します。

### 使い方

```bash
# エラーメッセージを直接渡す
echo "<error_message>" | gemini --prompt "このエラーの原因と解決方法を提案"

# エラーログから分析
cat error.log | gemini --prompt "エラーの根本原因を特定し、修正方法を提案"

# スタックトレースを分析
cat stacktrace.txt | gemini --prompt "スタックトレースから問題箇所を特定し、具体的な修正コードを提示"
```

### 活用例

1. **Rust のコンパイルエラー**
   ```bash
   cargo build 2>&1 | gemini --prompt "Rust のコンパイルエラーを解析し、修正方法を提案"
   ```

2. **実行時エラー**
   ```bash
   ./app 2>&1 | tail -50 | gemini --prompt "実行時エラーの原因と対処法を説明"
   ```

3. **テスト失敗**
   ```bash
   cargo test 2>&1 | gemini --prompt "失敗したテストを分析し、修正案を提示"
   ```

### 便利な使い方

```bash
# エラー修正関数
fix-error() {
  local error_output="$1"
  echo "$error_output" | gemini --prompt "エラーを分析し、1. 原因 2. 解決策 3. 修正コード例 を提示"
}

# 最後のコマンドのエラーを分析
fix-last-error() {
  !! 2>&1 | gemini --prompt "このエラーの解決方法を具体的に提示"
}
```

### コンテキスト付き分析

```bash
# ソースコードと一緒に分析
{ echo "=== ERROR ==="; cat error.log; echo "=== SOURCE ==="; cat main.rs; } | \
  gemini --prompt "エラーとソースコードから問題を特定し、修正方法を提案"
```