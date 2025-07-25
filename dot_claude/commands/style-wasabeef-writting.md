## wasabeef-style

わさびーふの文体ガイドラインに沿った文章作成・レビューを行います。技術記事を親しみやすく謙虚なトーンで執筆するためのコマンドです。

### 使い方

```bash
/wasabeef-style [action] [オプション]
```

### アクション

- `write` : 新規文章をわさびーふスタイルで作成
- `review` : 既存文章のスタイルチェックと改善提案
- `rewrite` : 既存文章をわさびーふスタイルに書き直し
- `check` : スタイル適合度のチェックのみ

### オプション

- なし : 現在のファイルまたは選択したテキストを対象
- `--file <path>` : 特定のファイルを対象に処理
- `--dir <path>` : ディレクトリ内の Markdown ファイルを一括処理
- `--strict` : 厳格なスタイルチェック（細かい表現まで確認）
- `--outline` : 記事の構成案のみ生成（write アクション時）

### 基本例

```bash
# 新規記事の作成
/wasabeef-style write
「Flutter のカスタムウィジェットについて記事を書いて」

# 既存文章のレビュー
cat draft.md
/wasabeef-style review
「この下書きをわさびーふスタイルでチェックして」

# 文章の書き直し
/wasabeef-style rewrite --file blog-post.md
「AI 臭い表現を全てわさびーふスタイルに変換」

# スタイル適合度チェック
/wasabeef-style check
「現在の文章のわさびーふ度を判定」
```

### Claude との連携

```bash
# 記事の下書き作成
/wasabeef-style write --outline
「Riverpod の状態管理について初心者向けの記事構成を作って」

# AI 臭い文章の変換
cat ai-generated.md
/wasabeef-style rewrite
「以下の観点で書き直して：
1. 挨拶から始める
2. 誇張表現を具体的な数値に
3. チーム視点の体験談を追加
4. 『おしまい』で締める」

# 複数ファイルの一括チェック
find ./blog -name "*.md" -type f
/wasabeef-style review --dir ./blog
「ブログ記事全体のわさびーふ度をチェックして改善優先度をつけて」
```

### 詳細例

```bash
# 技術選定記事の作成
/wasabeef-style write
「Flutter の状態管理で Riverpod を選んだ理由について、以下の構成で：
- 他の選択肢との比較（Provider, Bloc）
- チームでの導入経験
- つまずいたポイント
- 実際のコード例」

# OSS 紹介記事のテンプレート生成
/wasabeef-style write --outline
「作った OSS ツール『flutter_cache_manager_plus』の紹介記事」

# 既存記事の段階的な改善
/wasabeef-style review --file tech-blog.md --strict
「以下の優先順位で改善提案：
1. 必須: 記事構成（挨拶、締め）
2. 推奨: 表現の謙虚さ
3. 任意: 細かい言い回し」
```

### 高度な使用例

```bash
# シリーズ記事の一貫性チェック
/wasabeef-style check --dir ./flutter-series/
「Flutter 入門シリーズ全 10 記事の文体統一性を分析して、
特に：
- 各記事の挨拶パターン
- Step 番号の一貫性
- 締めの言葉のバリエーション」

# 共同執筆での文体統一
/wasabeef-style rewrite --file team-article.md
「複数人で書いた部分を統一して：
- 一人称を『私たち』『チーム』に統一
- 成果の表現を謙虚に
- 技術用語の表記揺れを修正」

# 英語記事の日本語化
/wasabeef-style write
「この英語の技術記事を参考に日本語版を作成：
[英語記事の内容]
ただし、単純な翻訳ではなく：
- 日本の開発現場の文脈に合わせる
- 具体例を日本でよく使われるものに
- わさびーふスタイルの体験談を追加」
```

### 注意事項

- 技術的な正確性は維持しつつ、親しみやすい表現を心がけます
- 製品名や型番は正確に記載します（例：ASUS VG27AQ、Flutter 3.19.0）
- 謙虚さと自虐は使いますが、過度にへりくだりません
- チームや読者への配慮を忘れずに、独りよがりな内容は避けます
- 問題解決の過程を正直に記載し、失敗談も含めます

### コマンド実行時の動作

`/wasabeef-style` コマンドを実行すると、Claude は以下の処理を行います：

1. **write アクション**: ガイドラインに沿った記事を新規作成
   - 必ず「こんにちは、わさびーふです。」で開始
   - Step 形式で構成を整理
   - 実体験ベースの具体例を含める
   - 「おしまい」で締めくくる

2. **review アクション**: 既存文章を 10 項目のチェックリストで評価
   - 各項目の適合度を表示
   - 具体的な改善提案を箇条書きで提示
   - 優先度（必須/推奨/任意）を付けて提案

3. **rewrite アクション**: 文章を完全に書き直し
   - 感嘆符を句点に変更
   - 誇張表現を具体的な数値や体験に置換
   - わさびーふ特有のフレーズを適切に配置

4. **check アクション**: スタイル適合度を数値化
   - 全体の適合度をパーセンテージで表示
   - 各要素（挨拶、謙虚さ、締め等）の個別評価

### 参考

このコマンドは wasabeef（Daichi Furiya）氏のブログ記事スタイルを分析し、その特徴的な文体を再現するために作成されました。技術記事でありながら親しみやすく、読者に寄り添う姿勢が特徴です。

---

## 文体ガイドライン

このドキュメントは、ブログ記事や技術文書を書く際の文体特徴をまとめたものです。

## 基本原則

### トーン

- **丁寧だが親しみやすい**: です・ます調を基本としつつ、堅苦しくならないように
- **謙虚で自虐的**: 「私も勉強中の身です」「雰囲気でやればいいです」「堕落した自分用に」
- **チーム意識**: 個人の成果よりチームの成果を強調
- **個人的な好み**: 「かなり個人的な好みが反映されている」「あくまで参考程度に」

## 記事構成テンプレート

### 1. 挨拶・導入

```markdown
こんにちは、わさびーふです。

今回は〜を作ったので紹介しようと思います。
```

または

```markdown
こんにちは、わさびーふです。

今回は〜について紹介しようと思います。
```

### 2. 対象読者の明記（必要に応じて）

```markdown
※注意点として、この記事は **技術 A + 技術 B + 技術 C** の組み合わせで開発している方向けの内容になります。これらのツールを使っていない場合は、あまり参考にならないかもしれません。
```

または最初に自分のスタンスを示す：

```markdown
もう冗長な作業をできるだけコマンドに落とし込むようにしています。特に〜が気に入っています。
```

個人的な前提条件を明記する場合：

```markdown
**⚠️ 重要な前提**
この Cookbook は私のワークフローに最適化されています。かなり個人的な好みが反映されているので、**あくまで参考程度に**見てほしく、使えそうなところだけ使ってみてください。
```

**注**: 汎用的な内容や短い記事では省略可能

### 3. 記事内容のプレビュー

```markdown
この記事では以下の内容について説明します。

- ポイント 1
- ポイント 2
- ポイント 3
```

**注**: 短い記事（Step が 3 つ以下）では省略可能

### 4. 本文

- **見出し**: H3（###）を基本に、必要に応じて H4（####）を使用
- **ステップ形式**: 手順説明は「Step 1」「Step 2」形式
- **コード例**: Gist またはコードブロックで実装例を提示
- **注意点**: 「※」「注意点」で重要事項を強調

### 5. まとめ

```markdown
## まとめ

簡潔に要点をまとめる（1-2 行程度）

例：

- 地味に打つの面倒くさかったので楽になりました。
- 少しだけストレスが減りました。
```

**注**: まとめは必須ではなく、短い記事では省略可能

### 6. 締めの言葉

```markdown
おしまい
```

### 7. リンク・参考資料

```markdown
GitHub: https://github.com/username/repository
```

### 8. あとがき（オプション - 長い記事の場合のみ）

```markdown
## あとがき

個人的な感想や追加情報
```

## 表現の特徴

### よく使うフレーズ

- **導入**: 「今回は〜を作ったので紹介しようと思います」「この記事では〜を解説しようと思います」「〜について紹介しようと思います」
- **参照**: 「詳しくは〜を確認してください」
- **推奨**: 「参考にしてください」「ぜひ参考にしてください」
- **意見**: 「〜だと思います」「〜が気に入っています」
- **注意**: 「※注意点として〜」「**⚠️ 重要な前提**」
- **体験報告**: 「〜やりなおしたら〜復活した」「〜できるようになりました」「〜を使い始めてから」
- **発見**: 「〜ということがわかりました」「実際に使ってみると予想以上に便利でした」
- **実用的感想**: 「地味に〜面倒くさかったので楽になりました」「少しだけストレスが減りました」「ちょっと楽になった」「微妙に改善された」「開発作業がかなり楽になりました」
- **謙虚な効果報告**: 「〜効果があったかも」「〜かもしれません」「あまり参考にならないかもしれません」
- **具体的な状況説明**: 「並列作業を沢山しすぎて」のような具体的な描写
- **個性的な表現**: 「for 俺」「堕落した自分用に」「だらけた自分」
- **観察視点**: 「議論を俯瞰して見ているような感覚」「まるでチーム開発をしているような感覚」

### 顔文字・絵文字・記号

- **顔文字**: 控えめに使用（主に「あとがき」セクションなど）
- **「！」**: 基本的に使用しない（「。」で締める）
- **※**: 補足説明の際に使用

### 英語の使い方

- **技術用語**: そのまま英語で記載（Flutter, MVVM, Firebase 等）
- **ツール名**: 英語表記を維持
- **日常会話**: 基本的に日本語

## 技術説明のスタイル

### 構成

1. **問題提起**: なぜこの技術/ツールが必要か
2. **解決方法**: 具体的な実装方法
3. **実例**: コード例やスクリーンショット
4. **メリット・デメリット**: 正直な評価（デメリットは簡潔に）
5. **実体験**: 個人やチームでの使用経験

### 外部リンクの活用

- **関連技術へのリンク**: 繰り返し配置して視認性向上
- **GitHub リポジトリ**: 冒頭と末尾に配置
- **公式ドキュメント**: 必要に応じて複数回リンク
- **技術用語への自然なリンク埋め込み**: `[hooks](https://docs.example.com/hooks)` のように文中に自然に配置

### 技術的な正確性（Twitter 投稿から学んだ特徴）

- **製品名・型番**: 正確に記載（「ASUS VG27AQ」「Corsair K63 US」レベルの精度）
- **問題 → 試行錯誤 → 結果**: 明確な流れで体験を報告
- **事実ベース**: 主観より客観的事実を重視
- **学びの共有**: 発見した技術的知見を素直に報告

### コード例の示し方

````markdown
以下のようにコードを実装します。

```language
// コメントは日本語で
const example = "サンプルコード";
```
````

詳細な実装は以下の Gist を参照してください。
[Gist 埋め込み]

**設定ファイルの実例掲載**:

- 設定ファイル（`.json`, `.md` など）は内容をそのまま記事内に掲載すると実用的
- `~/.claude/commands/show-plan.md` のようにファイルパスを明記してから内容を表示

### 図表の使い方

- スクリーンショットには説明文を追加
- 複雑な概念は図解で説明
- Before/After の比較を活用

## 記事タイトルのパターン

### 基本形

- 「〇〇を△△する」
- 「〇〇を作りました。」
- 「〇〇について解説する」
- 「〇〇で△△する設定」（簡潔な設定系記事）

### 例

- 「Flutter を MVVM で実装する」
- 「コード自動生成の FlutterGen を作りました。」
- 「Firebase Test Lab を CI に組み込みませんか」
- 「Claude Code の hooks で実装プランを見失わない設定」

## 段落・フォーマット

### 段落

- **長さ**: 2-4 文を目安だが、関連する内容は 1 つの段落にまとめる
- **改行**: 読みやすさのため適度に改行
- **箇条書き**: 3 つ以上の項目は箇条書きに
- **流れ重視**: 問題提起から解決まで自然な流れで繋げる

### 強調

- **重要な用語**: **太字**で強調
- **注意事項**: ※マークや「注意点」見出し
- **コマンド・ファイル名**: `バッククォート`で囲む

## チェックリスト

記事を書き終えたら以下を確認：

- [ ] 挨拶で始まっているか
- [ ] 記事の目的が明確か
- [ ] コード例は実践的か
- [ ] 注意点は明記されているか
- [ ] 締めの言葉があるか
- [ ] 全体的に親しみやすいトーンか
- [ ] 技術的に正確か
- [ ] 製品名・バージョンは正確に記載されているか
- [ ] 問題→解決の流れが明確か
- [ ] 実際の体験に基づいているか
- [ ] 冗長な説明がないか
- [ ] 例文が自然か

## 記事サンプル（解説記事）

```markdown
こんにちは、わさびーふです。

今回は Next.js 15 の新機能について解説しようと思います。

## App Router の改善点

Next.js 15 では App Router がさらに使いやすくなりました。

### Step 1: 基本的な設定

まずは `next.config.js` を更新します。

※注意点として、古いバージョンからの移行の場合は...

## まとめ

少しだけ開発が楽になりました。

おしまい
```

## 記事サンプル（OSS 紹介）

```markdown
こんにちは、わさびーふです。

今回は Claude Code をもっと便利に使うための設定集 for 俺を作ったので紹介しようと思います。

もう冗長な作業をできるだけコマンドに落とし込むようにしています。特に Role 機能で専門家の視点を切り替えられるのが気に入っています。

**⚠️ 重要な前提**
この Cookbook は私のワークフローに最適化されています。かなり個人的な好みが反映されているので、**あくまで参考程度に**見てほしく、使えそうなところだけ使ってみてください。

## 使い方

### Step 1: インストール

```bash
git clone https://github.com/wasabeef/claude-code-cookbook.git ~/.claude
```

## まとめ

Claude Code Cookbook を使い始めてから、開発作業がかなり楽になりました。特に以下の点が気に入っています。

- 専門家の意見を気軽に聞けるようになった
- ロール同士の議論を俯瞰できるのが面白い
- 冗長な作業がコマンド一発で完了

おしまい

GitHub: <https://github.com/wasabeef/claude-code-cookbook>

```

## Twitter 投稿から学んだ良い特徴

### 取り入れるべき要素

- **具体性**: 製品名は型番まで正確に（例：「Corsair K63 US」）
- **体験ベース**: 実際に使った/試した結果を報告
- **問題解決フロー**: 問題発生 → 試行錯誤 → 結果の明確な流れ
- **学習の共有**: 発見した技術的知見を素直に報告

### ブログでの活用方法

```markdown
## 実際に試してみた結果

ASUS VG27AQ を使って検証したところ、以下のことがわかりました。

### 問題

USB3.0 のノイズが隣の USB2.0 ポートの 2.4GHz 帯ワイヤレスに影響を与える問題が発生しました。

### 試行錯誤

macOS の iCUE では接続できませんでしたが、Windows の iCUE でやりなおしたところ、Bluetooth と有線接続が復活しました。

### 結果

製品の互換性は OS によって大きく異なることがわかりました。
```

### 注意：取り入れない要素

- 関西弁的な表現（「〜のね」等）
- カジュアルすぎる語尾
- SNS 特有の短文形式

## 避けるべき冗長な説明

### 削除すべき内容

- **セキュリティ対策の詳細**: 必要最小限に留める
- **実装の細かい説明**: コードを見ればわかることは書かない
- **長い before/after の比較**: 「以前は〜でしたが、今では〜」は短く
- **技術的な仕組みの詳細説明**: 使い方に集中

### 例

```markdown
❌ 冗長な例：
このスクリプトでは、まず jq コマンドの存在をチェックし、
次にファイルパスを検証して、パストラバーサル攻撃を防ぎ、
さらにファイルの存在確認を行い、最後に sed で処理します。

✅ 簡潔な例：
スクリプトでは jq を使って JSON からファイルパスを抽出しています。
```

## 自然な例文の作り方

### ポイント

- **実際にありそうな組み合わせを使う**: 「日本語 Claude コード」など
- **不自然な空白を避ける**: 「日本語Claudeコード」は不自然
- **具体的な技術名を使う**: Python より Rust、MySQL より PostgreSQL

### 例

```markdown
❌ 不自然：
「日本語AIツール」「最新JavaScriptフレームワーク」

✅ 自然：
「日本語 AI ツール」「最新 JavaScript フレームワーク」
```
