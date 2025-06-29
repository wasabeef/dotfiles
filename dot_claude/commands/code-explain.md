## Code Explain

選択したコードの動作を詳しく解説します。

### 使い方

```bash
# ファイル全体を解説
cat <file> | gemini --prompt "このコードの動作を初心者にもわかりやすく解説"

# 特定の関数を解説
grep -A 20 "function_name" <file> | gemini --prompt "この関数の目的と処理フローを説明"

# 複雑なロジックを解説
sed -n '10,30p' <file> | gemini --prompt "このコードブロックのロジックを step by step で解説"
```

### 活用例

1. **Rust の所有権を理解**
   ```bash
   cat main.rs | gemini --prompt "Rust の所有権とライフタイムの観点から解説"
   ```

2. **アルゴリズムの解説**
   ```bash
   grep -A 50 "quicksort" sort.rs | gemini --prompt "このソートアルゴリズムの仕組みと計算量を解説"
   ```

3. **デザインパターンの説明**
   ```bash
   cat factory.rs | gemini --prompt "使用されているデザインパターンとその利点を説明"
   ```

### オプション

```bash
# 図解付きで説明
cat <file> | gemini --prompt "処理の流れを図解（ASCII アート）付きで説明"

# 改善提案付き
cat <file> | gemini --prompt "コードの動作を解説し、改善点も提案"
```