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

**自分が Error を解決するにあたってこんなサービスがあったらと思っていたからです。** 

**前回作製した[Errorda!!](https://github.com/nachi739/Errorda-)でできなかったことを実現するため**

プログラミングをする過程で得た気づきや Error の解決方法などを体系的に残すことは難しく、Error を後でまとめようと思うが数日経ってしまい忘れて記録することができないということはよくあると思います。
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
- Docker
- Next.js
- React
- TypeScript
- Tailwind CSS
- Vercel
- Vite
- ESLint
- Prettier

## Notion の準備

- API-Key(Token)の取得:https://www.notion.so/my-integrations
  ---

  ![image](https://github.com/user-attachments/assets/f34eda35-ace1-4bf1-89ac-393a239d9bc9)
  
  ---

  ![image](https://github.com/user-attachments/assets/d26bdb2d-21c0-4521-8ea5-10cf50527ca4)

  ---

  ![image](https://github.com/user-attachments/assets/752caa05-1369-44c2-be5b-812bedd95a7a)

  ---

  ![image](https://github.com/user-attachments/assets/5ee4c38c-fe85-4859-9ba9-31859ef92414)

  ---

- Notion-Template の取得: [Template](https://honored-motion-55e.notion.site/129eaa80727680f19b06d02621f24066?v=129eaa807276819899ee000c30bb0f5b&pvs=4)
  ---

  ![image](https://github.com/user-attachments/assets/ce1e13ab-bc85-4aa1-bff2-95c8fa2d2ba6)

  ---

  ![image](https://github.com/user-attachments/assets/a5fa2250-2951-4327-bfad-2eeee7756d40)

  ---

  ![image](https://github.com/user-attachments/assets/097c62dc-39e7-440e-b114-882ec7cee757)

  ---
  
  ![image](https://github.com/user-attachments/assets/7dd09873-0ea3-4fde-b2af-0c20c38f9d33)

  ---

  ![image](https://github.com/user-attachments/assets/fbf94598-2e9b-41f3-bcf4-cf00a46ea51a)

  ---
  
- DATABASE-IDの取得:  
`https://www.notion.so/{Notion-DATABASE-ID}?v=000***`
  ---

![image](https://github.com/user-attachments/assets/c79e34a7-c123-41b0-a302-f73d5b93ebc6)

  ---

## Chrome 拡張機能

### 入手方法
[Chromeウェブストアリンクページ](https://chromewebstore.google.com/detail/errorda2-extension/kiokhdhbecikhmpdancgmchlpjjbbkjg)

### 初回 Notion-Key 情報登録画面
- NotionのTokenとDatabaseIDを登録します。

  <img width="315" alt="image" src="https://github.com/user-attachments/assets/1413c089-4b30-4307-b906-3323e7e27ac6">

### 検索画面

- 入力テキスト内容で Google 検索を新規タブで行います。
- NotionDB（新規作成し入力テキスト内容で Title に保存・Start time に検索押下時刻を保存）
- Key-resetをクリックするとNotion-Key　情報登録画面に遷移しKey情報を更新できます。

  <img width="315" alt="image" src="https://github.com/user-attachments/assets/1e4c93c3-3bf1-4aeb-a9ff-c9516de2b722">

### 検索中画面

- NotionDB(End time に解決押下時刻を保存・新規タブで NotionDB の詳細ページへ画面遷移)
- Error解決時に記載する内容の参考情報を箇条書きで記載

  <img width="315" alt="image" src="https://github.com/user-attachments/assets/090bb815-0ca0-4467-b6ef-13f481ef26d3">

### 開発環境の構築方法

[Chrome 拡張機能管理 Github](https://github.com/nachi739/errorda2_chrome_extensions/tree/main)を参照してください。

## バックエンド側

- Vercel を利用しデプロイ：https://errorda2.vercel.app
- NotionDB の Published フラグが有効になっているものを連携
- 一部マークダウン記法に現在対応（今後修正予定）

### 導入・構築方法

[バックエンド側管理 Github](https://github.com/nachi739/errorda2_next.js)を参照してください。

## ライセンス

このプロジェクトは [MIT ライセンス](./LICENSE) の下でライセンスされています。
