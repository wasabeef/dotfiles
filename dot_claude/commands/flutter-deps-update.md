## Flutter Dependencies Update

pubspec.yaml の依存関係を安全に最新化し、変更点を分析してコード更新を支援します。

### 使い方

```bash
# 1. 現在の依存関係を確認
cat pubspec.yaml

# 2. 古い依存関係をチェック
flutter pub deps --style=compact

# 3. Claude に依頼
「pubspec.yaml の依存関係を最新バージョンに更新して。各依存の Release Notes や CHANGELOG を確認し、破壊的変更や危険度を分析して」
```

### 更新の実行

```bash
# バックアップ作成と更新
cp pubspec.yaml pubspec.yaml.backup
flutter pub upgrade
flutter pub deps --style=compact

# 段階的更新（安全）
flutter pub upgrade --minor-versions
flutter test
```

### 依頼文の例

```
「pubspec.yaml の依存関係を分析し、以下を実行してください：

1. 各パッケージの最新バージョンを調査
2. Release Notes や CHANGELOG から破壊的変更を特定
3. 危険度を評価（安全・注意・危険）
4. 必要なコード変更を具体的に提案
5. 更新版 pubspec.yaml を生成

重点確認項目：
- API の変更
- 非推奨機能の削除
- 新しい必須パラメータ
- import パスの変更」
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

```dart
// 例：http パッケージの更新
// 旧バージョン（http ^0.13.0）
import 'package:http/http.dart' as http;
final response = await http.get('https://api.example.com');

// 新バージョン（http ^1.0.0）
import 'package:http/http.dart' as http;
final response = await http.get(Uri.parse('https://api.example.com'));

// 変更点：文字列 URL が Uri オブジェクトに変更
```

### 更新後の確認

```bash
flutter analyze
flutter test
```

### 緊急時の復元

```bash
# 問題が発生した場合
cp pubspec.yaml.backup pubspec.yaml
flutter pub get
```

