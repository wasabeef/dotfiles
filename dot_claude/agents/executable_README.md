# Agent Teams 構成

Claude Code Agent Teams 用の agent 定義。

## 設計方針

- **作業 = Sonnet + advisor**、**レビュー = Opus + Codex** (cross-model validation)
- Lead (Opus) は初期指示と調整のみ。全作業は teammate に委譲
- 1 role = 1 file で責務を明確に分離
- 全レビューにセキュリティ観点を含む
- Opus と Codex は同じレビュー観点で独立評価（セカンドオピニオン）
- 全 agent の出力は日本語（技術用語・コード・ファイルパスは原語のまま）
- レビュー ❌ → 修正 → 再レビュー → 承認のループで品質担保

## パイプライン

```
Lead (Opus): 初期指示
  │
  ▼
explorer (Sonnet): コードベース探索・構造把握
  │
  ▼
planner (Opus): 計画策定 → docs/plans/YYYY-MM-DD-<slug>/plan.md
  │
  ▼
plan-reviewer (Codex): 計画レビュー
  │ ❌ → planner 修正 → plan-reviewer 再レビュー → ✅ 承認まで
  ▼
★ ユーザー確認ゲート（計画の内容を提示し、実装に進むか確認する）
  │
  ▼
implementer (Sonnet + advisor): 実装
  │
  ├─▶ impl-reviewer-opus (Opus)     ┐
  ├─▶ impl-reviewer-codex (Codex)   ┤ 同一観点で独立評価
  └─▶ performance (Sonnet + advisor)┘ パフォーマンス分析
  │ ❌ → implementer 修正 → 再レビュー/再分析 → ✅ 承認まで
  ▼
  ├─▶ security-opus (Opus)  ┐
  └─▶ security-codex (Codex)┘ セキュリティ専門監査
  │ ❌ → implementer 修正 → security 再監査 → ✅ 承認まで
  ▼
tester (Sonnet + advisor): テスト
  │
  ├─▶ test-reviewer-opus (Opus)  ┐
  └─▶ test-reviewer-codex (Codex)┘ 同一観点で独立評価
  │ ❌ → tester 修正 → reviewer 再レビュー → ✅ 承認まで
  ▼
doc-writer (Sonnet + advisor): ドキュメント作成・更新
  │
  ├─▶ doc-reviewer-opus (Opus)  ┐
  └─▶ doc-reviewer-codex (Codex)┘ 同一観点で独立評価
  │ ❌ → doc-writer 修正 → reviewer 再レビュー → ✅ 承認まで
  ▼
doc-auditor (Sonnet): 既存ドキュメント全体の整合性監査
  ▼
完了
```

## Agent 一覧

### 作業系

| File | Name | Model | 責務 |
|------|------|-------|------|
| `explorer.md` | explorer | Sonnet | コードベース探索・構造把握。planner に情報提供 |
| `planner.md` | planner | Opus | 計画策定。`docs/plans/` に md 出力 |
| `implementer.md` | implementer | Sonnet + advisor | コード実装・修正 |
| `tester.md` | tester | Sonnet + advisor | テスト設計・実装・実行 |
| `doc-writer.md` | doc-writer | Sonnet + advisor | ドキュメント作成・更新 |
| `doc-auditor.md` | doc-auditor | Sonnet | 既存ドキュメントの整合性監査 |
| `performance.md` | performance | Sonnet + advisor | パフォーマンス分析・ベンチマーク |

### レビュー/監査系 (Opus + Codex、同一観点で独立評価)

> **例外**: plan-reviewer は Codex のみ。planner が Opus のため、same-model review を避ける設計。
>
> **Model 列の "Codex"**: frontmatter 上は `model: sonnet` + `skills: [codex-cli-runtime]`。Sonnet が Codex CLI を呼び出す構造。

| File | Name | Model | 対象 |
|------|------|-------|------|
| `plan-reviewer.md` | plan-reviewer | Codex | 計画（Opus ペアなし — planner が Opus のため） |
| `impl-reviewer-opus.md` | impl-reviewer-opus | Opus | 実装 |
| `impl-reviewer-codex.md` | impl-reviewer-codex | Codex | 実装 |
| `test-reviewer-opus.md` | test-reviewer-opus | Opus | テスト |
| `test-reviewer-codex.md` | test-reviewer-codex | Codex | テスト |
| `doc-reviewer-opus.md` | doc-reviewer-opus | Opus | ドキュメント |
| `doc-reviewer-codex.md` | doc-reviewer-codex | Codex | ドキュメント |
| `security-opus.md` | security-opus | Opus | セキュリティ専門監査 |
| `security-codex.md` | security-codex | Codex | セキュリティ専門監査 |

### オンデマンド

| File | Name | Model | 用途 |
|------|------|-------|------|
| `analyzer.md` | analyzer | Opus | 根本原因分析。バグ調査・障害対応時に spawn |

## ワークフローパターン

ユーザーの指示に応じて、必要な teammate だけを spawn する。

### フルパイプライン

全フェーズを順に実行。新機能追加やリファクタリング向け。

```
チームで gemini 対応を実装して。
```

spawn: explorer → planner → plan-reviewer → implementer → impl-reviewer-opus/codex + performance → security-opus/codex → tester → test-reviewer-opus/codex → doc-writer → doc-reviewer-opus/codex → doc-auditor

### レビューのみ

既存コードや PR を多角的にレビュー。計画・実装は不要。

```
チームでこの PR をレビューして。
```

spawn: impl-reviewer-opus + impl-reviewer-codex（並列）

### 計画のみ

実装方針を策定し、ユーザー確認で止める。

```
チームで実装方針を決めて。
```

spawn: explorer → planner → plan-reviewer → ★ ユーザー確認ゲート

### テストのみ

既存実装に対してテストを追加・レビュー。

```
チームでテストを書いて。
```

spawn: tester → test-reviewer-opus + test-reviewer-codex

### ドキュメントのみ

変更に対するドキュメントを作成・レビュー。

```
チームでドキュメントを整備して。
```

spawn: doc-writer → doc-reviewer-opus + doc-reviewer-codex → doc-auditor

### セキュリティ監査のみ

実装コードのセキュリティを専門的に監査。

```
チームでセキュリティ監査して。
```

spawn: security-opus + security-codex（並列）

### バグ調査

原因不明の不具合を根本原因分析。

```
チームでこのバグの原因を調べて。
```

spawn: analyzer

### ドキュメント監査のみ

既存ドキュメントの正確性・整合性をチェック。

```
チームでドキュメントの監査をして。
```

spawn: doc-auditor

## 前提条件

- `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` が有効
- `model: opus[1m]` が設定済 (Lead)
- Codex plugin (`codex@openai-codex`) が有効
- `/advisor opus` をセッション開始時に実行

## advisor と Opus reviewer の役割分担

| | advisor | Opus reviewer |
|---|---|---|
| タイミング | 作業中 | 作業完了後 |
| 呼び出し | Sonnet が自律的に `advisor()` | Lead がタスク割当 |
| 目的 | 実装品質の底上げ | 独立した最終レビュー |
| 視点 | 局所的（今の判断） | 全体的（成果物全体） |

## 成果物ディレクトリ

```
docs/plans/YYYY-MM-DD-<slug>/
├── plan.md                    ← planner
├── plan-review-codex.md       ← plan-reviewer
├── impl-review-opus.md        ← impl-reviewer-opus
├── impl-review-codex.md       ← impl-reviewer-codex
├── test-review-opus.md        ← test-reviewer-opus
├── test-review-codex.md       ← test-reviewer-codex
├── doc-review-opus.md         ← doc-reviewer-opus
├── doc-review-codex.md        ← doc-reviewer-codex
├── security-audit-opus.md     ← security-opus
├── security-audit-codex.md    ← security-codex
└── performance-analysis.md    ← performance
```

## レビュー評価基準

- ✅ 問題なし
- ⚠️ 要検討 (ブロッカーではない)
- ❌ 要修正 (差し戻し)

## 差し戻し・承認ループ

```
reviewer ❌ → Lead → 作業 agent 修正 → Lead → reviewer 再レビュー
  ├─ ✅ 承認 → 次フェーズへ
  └─ ❌ 再指摘 → ループ
```

| レビュー元 | 差し戻し先 | 修正対象 |
|---|---|---|
| plan-reviewer | planner | plan.md |
| impl-reviewer-opus / codex | implementer | 実装コード |
| performance | implementer | 実装コード (perf 指摘) |
| security-opus / codex | implementer | 実装コード (sec 指摘) |
| test-reviewer-opus / codex | tester | テストコード |
| doc-reviewer-opus / codex | doc-writer | ドキュメント |

### dual review での判断

- Opus ❌ + Codex ❌ → 差し戻し
- Opus ❌ + Codex ✅ (or 逆) → Lead が判断
- Opus ⚠️ + Codex ⚠️ → 原則パス、同一箇所なら修正推奨
