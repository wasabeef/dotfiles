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
- 極力並列化。直列は依存関係が不可避な箇所のみ
- **Spec-Driven**: planner が仕様 (what) と実装計画 (how) を plan.md に統合。仕様が全 teammate の判断基準

## パイプライン概要図

人間向けの俯瞰図。AI Lead は「実行手順」セクションに従うこと。

```
Phase 0 — チーム初期化 (全パターン共通)
  TeamCreate → TaskCreate → 以降の全 spawn に team_name + name を指定

Phase 1 — 直列
  Lead → explorer → planner → plan-reviewer ⇄ planner → ★gate → implementer

Phase 2 — impl dual review (並列 tool call)
  ├─▶ impl-reviewer-opus  ┐
  └─▶ impl-reviewer-codex ┘ → ❌ なら implementer 修正 → 再実行

Phase 3 — 最大 fan-out (全 run_in_background: true)
  ├─▶ security-opus ──────────────────────────────┐
  ├─▶ security-codex ─────────────────────────────┤
  ├─▶ performance ────────────────────────────────┤
  ├─▶ tester → test-reviewer-opus/codex ──────────┤
  └─▶ doc-writer → doc-reviewer-opus/codex ───────┘
      security/performance ❌ → implementer 修正 → Phase 2 から再実行

Phase 4 — join → 最終監査
  doc-auditor → ❌ なら doc-writer 修正 → doc-review → doc-auditor 再実行
  → 完了
```

## 実行手順 (Lead 用)

### Phase 0 — チーム初期化

> **重要**: この手順を省略すると teammate ではなく通常 subagent として spawn される。必ず最初に実行すること。

0a. TeamCreate でチームを作成:

```
TeamCreate({ team_name: "<slug>", description: "タスクの説明" })
```

0b. パイプライン全体のタスクを TaskCreate で登録 (Phase 1 〜 4 の主要タスク)

0c. 以降の全 Agent() 呼び出しに team_name と name を指定:

```
Agent({
  team_name: "<slug>",
  name: "explorer",
  subagent_type: "explorer",
  prompt: "..."
})
```

- team_name なし → 通常 subagent (teammate にならない)
- name なし → SendMessage で参照不可

0d. teammate との通信は SendMessage を使用:

```
SendMessage({ to: "<name>", message: "..." })
```

0e. タスク完了時は TaskUpdate で status を更新
0f. **retry 時は既存 teammate に SendMessage で再依頼する。新しい Agent() を spawn しない。**
    - 新規 spawn すると `-2` サフィックス付きの別 teammate が生成され、前回のコンテキストが失われる
    - 正: `SendMessage({ to: "impl-reviewer-opus", message: "修正内容: ... 再レビューしてください" })`
    - 誤: `Agent({ name: "impl-reviewer-opus", ... })` ← 別インスタンスが生成される

### Phase 1 — 直列

1. **explorer** を spawn。結果を保持
2. **planner** を spawn (explorer の結果を渡す)
3. **plan-reviewer** を spawn (plan.md を渡す) 。※ Codex 単独 (dual review なし)
   - IF ✅ → step 4 へ
   - IF ⚠️ → Lead が指摘を精査。妥当なら planner 修正 → step 3、軽微なら step 4 へ
   - IF ❌ → SendMessage で planner に指摘を渡して修正 → SendMessage で plan-reviewer に再レビュー依頼
4. ユーザーに計画を提示し確認を求める
   - IF 承認 → step 5 へ
   - IF 却下/修正指示 → planner に修正指示 → step 3 に戻る
5. **implementer** を spawn

### Phase 2 — impl dual review

6. 並列 tool call で spawn (background 不使用):
   - **impl-reviewer-opus**
   - **impl-reviewer-codex**
7. 両方の結果を待機し **dual review 判定**:
   - IF 両方 ✅ → Phase 3 へ (step 8)
   - IF 両方 ❌ → SendMessage で implementer に両方の指摘を渡して修正 → SendMessage で既存 reviewer に再レビュー依頼
   - IF 片方 ❌ + 片方 ✅ → Lead が ❌ 側の指摘を精査:
     - 妥当 → SendMessage で implementer 修正 → SendMessage で既存 reviewer に再レビュー依頼
     - 過剰 → Phase 3 へ (理由を記録)
   - IF 両方 ⚠️ → 同一箇所指摘なら implementer 修正 → step 6、異なれば Phase 3 へ

> **dual review 判定ルール**: 以降の全 dual review (security, test-reviewer, doc-reviewer) も同じルールを適用する。performance のみ単独判定 (定量的指標ベースのため cross-model 不要) 。

### Phase 3 — fan-out

8. 以下を**全て `run_in_background: true`** で spawn:
   - **security-opus**
   - **security-codex**
   - **performance**
   - **tester**
   - **doc-writer**

9. 完了通知を受け取り次第、通知ごとに処理 (通知順序は不定。全 branch は独立して進行し、途中で中断しない。統合評価は step 10 で行う):

   **tester 完了時:**
   - **test-reviewer-opus** + **test-reviewer-codex** を並列 spawn
   - dual review 判定 (step 7 と同じルール)
   - IF ❌ → SendMessage で tester に指摘を渡して修正 → SendMessage で既存 test-reviewer に再レビュー依頼 (✅ まで)

   **doc-writer 完了時:**
   - **doc-reviewer-opus** + **doc-reviewer-codex** を並列 spawn
   - dual review 判定 (step 7 と同じルール)
   - IF ❌ → SendMessage で doc-writer に指摘を渡して修正 → SendMessage で既存 doc-reviewer に再レビュー依頼 (✅ まで)

   **security-opus / security-codex / performance 完了時:**
   - 結果を保持。step 10 で評価

10. **全 background agent + follow-up chain 完了後**、security / performance 結果を評価:
    - security-opus + security-codex → dual review 判定 (step 7 と同じルール)
    - performance → 単独判定 (dual review ペアなし。※ perf 分析は定量的指標ベースのため cross-model 不要)
    - IF 全て ✅ or ⚠️ → Phase 4 へ (step 11)
    - IF security or performance ❌ → step 10a へ
    - IF security ❌ + test-reviewer ❌ 同時発生 → step 10a へ (security 修正を優先)

10a. **security / performance 差し戻し処理** (コード修正が必要なため Phase 2 から再実行):
    - SendMessage で implementer に指摘 (sec / perf) を渡して修正
    - SendMessage で既存 impl-reviewer に再レビュー依頼 (Phase 2 再実行 → step 7 → step 8 へ自然に進行)
    - step 8 再 fan-out 時、Lead は以下を判断:
      - security / performance → 全再実行
      - tester / doc-writer → 差分影響で判断:
        - API 署名・公開 IF・主要ロジック変更 → 再実行
        - 内部実装の軽微修正 → 既存結果を再利用
      - security ❌ + test-reviewer ❌ だった場合 → tester も全再実行

### Phase 4 — join → 最終監査

11. **doc-auditor** を spawn (全成果物を渡す)
    - IF ✅ → step 12 へ
    - IF ❌ → SendMessage で doc-writer に指摘を渡して修正
      → SendMessage で既存 doc-reviewer に再レビュー依頼 (dual review 判定)
      → ✅ 後 doc-auditor 再実行 (✅ まで)
12. ユーザーにチーム終了を確認:
    - 「全タスク完了。チームをシャットダウンしてよいか？」と提示
    - IF 承認 → step 12a へ
    - IF 却下 → チーム維持。ユーザーが追加指示可能な状態で待機
12a. チームクリーンアップ:
    - 全 teammate に `SendMessage({ to: "<name>", message: { type: "shutdown_request" } })` を送信
    - 全 teammate の終了を確認
    - `TeamDelete()` でチーム・タスクリストを削除
13. 完了報告

## Agent 一覧

### 作業系

| File             | Name        | Model            | 責務                                           |
| ---------------- | ----------- | ---------------- | ---------------------------------------------- |
| `explorer.md`    | explorer    | Sonnet           | コードベース探索・構造把握。planner に情報提供 |
| `planner.md`     | planner     | Opus             | 仕様 (what) + 実装計画 (how) を plan.md に策定 |
| `implementer.md` | implementer | Sonnet + advisor | コード実装・修正                               |
| `tester.md`      | tester      | Sonnet + advisor | テスト設計・実装・実行                         |
| `doc-writer.md`  | doc-writer  | Sonnet + advisor | ドキュメント作成・更新                         |
| `doc-auditor.md` | doc-auditor | Sonnet           | 既存ドキュメントの整合性監査                   |
| `performance.md` | performance | Sonnet + advisor | パフォーマンス分析・ベンチマーク               |

### レビュー/監査系 (Opus + Codex、同一観点で独立評価)

> **例外**: plan-reviewer は Codex のみ。planner が Opus のため、same-model review を避ける設計。
>
> **Model 列の "Codex"**: frontmatter 上は `model: sonnet` + `skills: [codex-cli-runtime]`。Sonnet が Codex CLI を呼び出す構造。

| File                     | Name                | Model | 対象                                           |
| ------------------------ | ------------------- | ----- | ---------------------------------------------- |
| `plan-reviewer.md`       | plan-reviewer       | Codex | 計画（Opus ペアなし — planner が Opus のため） |
| `impl-reviewer-opus.md`  | impl-reviewer-opus  | Opus  | 実装                                           |
| `impl-reviewer-codex.md` | impl-reviewer-codex | Codex | 実装                                           |
| `test-reviewer-opus.md`  | test-reviewer-opus  | Opus  | テスト                                         |
| `test-reviewer-codex.md` | test-reviewer-codex | Codex | テスト                                         |
| `doc-reviewer-opus.md`   | doc-reviewer-opus   | Opus  | ドキュメント                                   |
| `doc-reviewer-codex.md`  | doc-reviewer-codex  | Codex | ドキュメント                                   |
| `security-opus.md`       | security-opus       | Opus  | セキュリティ専門監査                           |
| `security-codex.md`      | security-codex      | Codex | セキュリティ専門監査                           |

### オンデマンド

| File          | Name     | Model | 用途                                       |
| ------------- | -------- | ----- | ------------------------------------------ |
| `analyzer.md` | analyzer | Opus  | 根本原因分析。バグ調査・障害対応時に spawn |

## ワークフローパターン

ユーザーの指示に応じて、必要な teammate だけを spawn する。

> **全パターン共通**: 必ず Phase 0 (TeamCreate) を最初に実行する。全 agent は teammate として spawn し、完了時は TeamDelete でクリーンアップする。

### フルパイプライン

全フェーズを順に実行。新機能追加やリファクタリング向け。

```
チームで gemini 対応を実装して。
```

Phase 0 → Phase 1 〜 4 の実行手順に従う

### レビューのみ

既存コードや PR を多角的にレビュー。

```
チームでこの PR をレビューして。
```

Phase 0 → impl-reviewer-opus + impl-reviewer-codex (並列) → dual review 判定

### 計画のみ

実装方針を策定し、ユーザー確認で止める。

```
チームで実装方針を決めて。
```

Phase 0 → explorer → planner ⇄ plan-reviewer → ★ ユーザー確認ゲート

### テストのみ

既存実装に対してテストを追加・レビュー。

```
チームでテストを書いて。
```

Phase 0 → tester ⇄ test-reviewer-opus + test-reviewer-codex

### ドキュメントのみ

変更に対するドキュメントを作成・レビュー。

```
チームでドキュメントを整備して。
```

Phase 0 → doc-writer ⇄ doc-reviewer-opus + doc-reviewer-codex → doc-auditor

### パフォーマンス + セキュリティ監査

実装コードの非機能要件を監査。

```
チームでセキュリティとパフォーマンスを監査して。
```

Phase 0 → security-opus + security-codex + performance（全並列）

### セキュリティ監査のみ

実装コードのセキュリティを専門的に監査。

```
チームでセキュリティ監査して。
```

Phase 0 → security-opus + security-codex（並列）

### バグ調査

原因不明の不具合を根本原因分析。

```
チームでこのバグの原因を調べて。
```

Phase 0 → analyzer

### ドキュメント監査のみ

既存ドキュメントの正確性・整合性をチェック。

```
チームでドキュメントの監査をして。
```

Phase 0 → doc-auditor

## 前提条件

- `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` が有効
- `model: opus[1m]` が設定済 (Lead)
- Codex plugin (`codex@openai-codex`) が有効
- `/advisor opus` をセッション開始時に実行

## advisor と Opus reviewer の役割分担

|            | advisor                       | Opus reviewer        |
| ---------- | ----------------------------- | -------------------- |
| タイミング | 作業中                        | 作業完了後           |
| 呼び出し   | Sonnet が自律的に `advisor()` | Lead がタスク割当    |
| 目的       | 実装品質の底上げ              | 独立した最終レビュー |
| 視点       | 局所的（今の判断）            | 全体的（成果物全体） |

## 成果物ディレクトリ

```
docs/plans/YYYY-MM-DD-<slug>/
├── exploration.md               ← explorer
├── plan.md                      ← planner
└── reviews/
    ├── plan-codex.md            ← plan-reviewer
    ├── impl-opus.md             ← impl-reviewer-opus
    ├── impl-codex.md            ← impl-reviewer-codex
    ├── test-opus.md             ← test-reviewer-opus
    ├── test-codex.md            ← test-reviewer-codex
    ├── doc-opus.md              ← doc-reviewer-opus
    ├── doc-codex.md             ← doc-reviewer-codex
    ├── security-opus.md         ← security-opus
    ├── security-codex.md        ← security-codex
    └── performance.md           ← performance
```

命名規則: `<対象>-<model>.md` (reviews/ 配下のため review/audit/analysis は省略)

retry 時は同ファイルを上書き。git diff で差分確認。

## レビュー評価基準

- ✅ 問題なし
- ⚠️ 要検討 (ブロッカーではない)
- ❌ 要修正 (差し戻し)
