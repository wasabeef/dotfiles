## Node.js Dependencies Update

package.json の依存関係を安全に最新化し、変更点を分析してコード更新を支援します。

### 使い方

```bash
# 1. 現在の依存関係を確認
cat package.json
npm outdated

# 2. Claude に依頼
「package.json の依存関係を最新化して。Release Notes や CHANGELOG から破壊的変更を特定し、必要なコード修正も提案して」
```

### 更新の実行

```bash
# バックアップ作成と更新
cp package.json package.json.backup
npm update
npm list --depth=0

# 段階的更新（安全）
npm update --save
npm test
```

### 依頼文の例

```
「package.json の依存関係を分析し、以下を実行してください：

1. 各パッケージの最新バージョンを調査
2. Release Notes や CHANGELOG から破壊的変更を特定
3. 危険度を評価（安全・注意・危険）
4. 必要なコード変更を具体的に提案
5. 更新版 package.json を生成

重点確認項目：
- API の変更
- 非推奨機能の削除
- 新しい必須パラメータ
- TypeScript 型定義の変更」
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
```

### 自動コード修正の例

```javascript
// 例：axios パッケージの更新
// 旧バージョン（axios ^0.27.0）
import axios from 'axios';
const response = await axios.get('/api/users');

// 新バージョン（axios ^1.0.0）
import axios from 'axios';
const response = await axios.get('/api/users', {
  validateStatus: function (status) {
    return status < 500; // デフォルト動作が変更されている場合
  }
});
```

### 更新後の確認

```bash
npm test
npm run build
npm audit
```

### 緊急時の復元

```bash
# 問題が発生した場合
cp package.json.backup package.json
npm install
```