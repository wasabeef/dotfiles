## Role

特定のロール（役割）に切り替えて、専門的な分析や作業を実行します。

### 使い方

```bash
/role <ロール名>
```

### 利用可能なロール

#### 既存ロール（SuperClaude 機能統合済み）

- `security` : セキュリティ監査の専門家として動作（OWASP・脅威モデリング強化）
- `reviewer` : コードレビュアーとして品質チェック
- `architect` : システムアーキテクトとして設計分析（Evidence-First 設計統合）
- `qa` : テストエンジニアとしてテスト戦略立案

#### 新規ロール（SuperClaude ペルソナ統合）

- `performance` : パフォーマンス最適化の専門家として動作
- `analyzer` : 根本原因分析の専門家として動作
- `frontend` : フロントエンド・UI/UX の専門家として動作
- `mobile` : モバイル開発の専門家として動作

### 基本例

```bash
# セキュリティ監査モードに切り替え
/role security
「このプロジェクトのセキュリティ脆弱性をチェックして」

# コードレビューモードに切り替え
/role reviewer
「最近の変更をレビューして改善点を指摘して」

# パフォーマンス最適化モードに切り替え
/role performance
「アプリケーションのボトルネックを分析して」

# 根本原因分析モードに切り替え
/role analyzer
「この障害の根本原因を調査して」

# フロントエンド専門モードに切り替え
/role frontend
「UI/UX の改善点を評価して」

# モバイル開発専門モードに切り替え
/role mobile
「このアプリのモバイル最適化を評価して」

# 通常モードに戻る
/role default
「通常の Claude に戻ります」
```

### Claude との連携

```bash
# セキュリティ特化の分析
/role security
cat app.js
「このコードの潜在的なセキュリティリスクを詳細に分析して」

# アーキテクチャ観点での評価
/role architect
ls -la src/
「現在の構造の問題点と改善案を提示して」

# テスト戦略の立案
/role qa
「このプロジェクトに最適なテスト戦略を提案して」
```

### 詳細例

```bash
# 複数ロールでの分析
/role security
「まずセキュリティ観点でチェック」
git diff HEAD~1

/role reviewer
「次に一般的なコード品質をレビュー」

/role architect
「最後にアーキテクチャの観点から評価」

# ロール固有の出力形式
/role security
🔒 セキュリティ分析結果
━━━━━━━━━━━━━━━━━━━━━
脆弱性: SQL インジェクション
深刻度: High
該当箇所: db.js:42
修正案: パラメータ化クエリを使用
```

### ロールの特徴

#### 既存ロール（SuperClaude 機能統合済み）

##### security

- OWASP Top 10 に基づく脆弱性検出
- 脅威モデリング（STRIDE・Attack Tree・PASTA）
- Evidence-Based セキュリティ監査
- Zero Trust 原則・CVE データベース照合

##### reviewer

- 可読性、保守性、パフォーマンスの観点
- コーディング規約の遵守チェック
- リファクタリング提案

##### architect

- Evidence-First 設計原則（公式文書確認）
- MECE 分析による段階的思考プロセス
- 進化的アーキテクチャ設計
- 複数視点からの評価（技術・ビジネス・運用・ユーザー）

##### qa

- テストカバレッジの分析
- E2E、統合、単体テストの戦略
- テスト自動化の提案

#### 新規ロール（SuperClaude ペルソナ統合）

##### performance

- Core Web Vitals・RAIL モデル準拠
- Evidence-First パフォーマンス最適化
- ボトルネック分析・ROI 評価
- 段階的最適化ロードマップ

##### analyzer

- 根本原因分析（5 Whys・魚骨図・FMEA）
- 仮説駆動・証拠ベース調査
- システム思考・認知バイアス対策
- Evidence-First 問題解決

##### frontend

- Evidence-First フロントエンド開発
- デザインシステム標準準拠（Material Design・HIG）
- WCAG 2.1 アクセシビリティ準拠
- デザインシンキング・ユーザー中心設計

##### mobile

- プラットフォーム公式ガイドライン準拠（iOS HIG・Android Material Design）
- クロスプラットフォーム戦略・Touch-First 設計
- モバイル特化 UX・コンテキスト適応設計
- ストアガイドライン準拠・パフォーマンス最適化

## 高度なロール機能

### インテリジェントロール選択
- `/smart-review` : プロジェクト分析による自動ロール提案
- `/role-help` : 状況に応じた最適ロール選択ガイド

### マルチロール協調
- `/multi-role <ロール1>,<ロール2>` : 複数ロール同時分析
- `/role-debate <ロール1>,<ロール2>` : ロール間議論

### 使用例

#### 自動ロール提案
```bash
/smart-review
→ 現在の状況を分析して最適なロールを提案

/smart-review src/auth/
→ 認証関連ファイルから security ロールを推奨
```

#### 複数ロール分析
```bash
/multi-role security,performance
「この API を複数の視点で評価して」
→ セキュリティとパフォーマンスの両面から統合分析

/role-debate frontend,security
「2段階認証の UX について議論して」
→ ユーザビリティとセキュリティの観点で議論
```

#### ロール選択に迷った場合
```bash
/role-help "API が遅くてセキュリティも心配"
→ 適切なアプローチ（multi-role や debate）を提案

/role-help compare frontend,mobile
→ フロントエンドとモバイルロールの違いと使い分け
```

## 注意事項

- ロールを切り替えると、Claude の振る舞いと優先事項が変化します
- 各ロールの詳細設定は `.claude/roles/` ディレクトリ内のファイルで定義
- `default` で通常モードに戻ります
- ロールは現在のセッション内でのみ有効です
- 複雑な問題ほど multi-role や role-debate が効果的です
- 迷った時は smart-review や role-help をご利用ください
