# Errorda2

## サービスの概要

**Errorda2 は Error 解決のプロセスと成長過程を可視化するためのものです。**
**エラー文を検索する際にエラー文の保存とクローム検索を一度に行います。**

- Error 解決に掛かった時間を記録します。
- Error 解決直後に解決に至るまでに閲覧した URL や解決のヒントなどをメモに残すことができます。
- 未経験エンジニアをマネジメントする方（未経験エンジニアがどのように検索しているか知り、フィードバックするための OJT 補助ツール）
- 有名記事サイトに投稿はハードルが高いと感じている方。

## 想定されるユーザー

- プログラミングを行なっている方
- Error 解決の記録を体系的に整理し残したい方
- 気軽にアウトプットする練習がしたい方

### このアプリを作った背景

**自分が Error を解決するにあたってこんなサービスがあったらと思っていたからです。** プログラミングをする過程で得た気づきや Error の解決方法などを体系的に残すことは難しく、Error を後でまとめようと思うが数日経ってしまい忘れて記録することができないということはよくあると思います。
そういった背景から、自分が Error を解決するにあたって Error に直面した際にどのようなワードで検索をしているのかの把握し、自分独自の Error 解決辞書を作成するといったものができないかと思い本アプリを作成しました。

## ユーザーが持つ課題

- ①Error 解決に役に立つサイトを都度ルールなくブックマーク登録することによって結果検索性の低下
- ②Error 解決後に「なぜ」の時間を取らないため再度同じ Error に詰まることがある
- ③ 記録を体系的に残すことができず、Error 解決量と成長量がイメージしにくい（実感しにくい）
- ④ 直面したエラーに対してすぐメモを残し、かつ検索できるツールがない

## 課題の解決方法（このサービスでどうやって解決するか）

- 解決した Error について NotionDB に URL を登録しブックマーク迷子を卒業する（①）
- Error 解決直後に記録を残すため無意識に時間が取れ、アウトプットの練習にもなる（②,③）
- 解決までの時間やその月に解決した Error の数を一つの結果として捉える（③）
- ノートツールとして有名な Notion を軸に解決する（④）

## 使用技術

- Notion
- Next.js
- React
- TypeScript
- Tailwind CSS
- Vercel
- Vite
- ESLint
- Prettier

## Notionの準備

- API-Key(Token)の取得:https://www.notion.so/my-integrations
- Notion-Templateの取得: [Template](https://honored-motion-55e.notion.site/129eaa80727680f19b06d02621f24066?v=129eaa807276819899ee000c30bb0f5b&pvs=4)
- Notion-DATABASE-IDの取得:`https://www.notion.so/{Notion-DATABASE-ID}?v=000***********`

## Chrome拡張機能

### 初回Notion-Key情報登録画面
<img width="241" alt="image" src="https://github.com/user-attachments/assets/c2627d18-d30c-474f-ad49-eee7a4d60fee">

### 検索画面
- 入力テキスト内容でGoogle検索を新規タブで行います。
- NotionDB（新規作成し入力テキスト内容でTitleに保存・Start timeに検索押下時刻を保存）
<img width="237" alt="image" src="https://github.com/user-attachments/assets/d8f51e30-5b06-4e5b-bf2c-cf5a32007f81">

### 検索中画面
- NotionDB(End timeに解決押下時刻を保存・新規タブでNotionDBの詳細ページへ画面遷移)
<img width="240" alt="image" src="https://github.com/user-attachments/assets/4930cc5e-ae13-49d2-a4d9-13e0b8e61ba5">

### 導入・構築方法
[Chrome拡張機能管理Github](https://github.com/nachi739/errorda2_chrome_extensions/tree/main)を参照してください。

## バックエンド側
- Vercelを利用しデプロイ：https://errorda2.vercel.app
- NotionDBのPublishedフラグが有効になっているものを連携
- 一部マークダウン記法に現在対応（今後修正予定）

### 導入・構築方法
[バックエンド側管理Github](https://github.com/nachi739/errorda2_next.js)を参照してください。

## ライセンス

このプロジェクトは [MIT ライセンス](./LICENSE) の下でライセンスされています。
