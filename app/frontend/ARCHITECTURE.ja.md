# o6ua6の処理・Store設計

## GET /

画面にランダムな2つの元号候補が表示される。

### Process

1. Railsアプリで2つのランダムな元号候補が選ばれる
2. または`GET /random/2`にアクセスして2つのランダムな元号候補を取得する

この際、セッション情報から過去に投票した候補（勝ち・負け双方）`store.history`は除外する。

元号候補は`store.stage`に格納される。
Viewでは2つの元号候補が「vs」の形式で表示される。（マウントされる）

### Store

```json
{
  "stage": [
    {
      "identifier": "497a5e9a2b5e",
      "surface": "岩委",
      "yomi": [
        "ガンイ"
      ],
      "imageUrls": [
        "https://o6ua6.s3.amazonaws.com/images/9a2b5e.jpg",
        "https://o6ua6.s3.amazonaws.com/images/497a5e.jpg"
      ]
    },
    {
      "identifier": "29d99e1b585e",
      "surface": "共青",
      "yomi": [
        "キョウショウ",
        "キョウセイ"
      ],
      "imageUrls": [
        "https://o6ua6.s3.amazonaws.com/images/1b585e.jpg",
        "https://o6ua6.s3.amazonaws.com/images/29d99e.jpg"
      ]
    }
  ],
  "history": [ /* 以下は省略しているが各項目はstageと同じ構造 */
    [ { "identifier": "8b0b6e8b886e" },
      { "identifier": "ca685e38088e" } ],
    [ { "identifier": "da8b4e5ab88e" },
      { "identifier": "c81a8e497a5e" } ]
  ]
}
```

`store.stage`はセッション情報(localStorage)に保存されない。

## 元号候補をタップする

元号候補はそれぞれタップ可能で、タップされた方が「勝ち」。

### Process

1. `Stage`上の2つの元号候補のうちいずれかをタップする
2. タップされた元号を勝ち、されなかった方を負けとして`POST /vote`へ投稿
3. 負けた方が内側下部を中心として外側へ回転しつつフェードアウトして消える
4. `Stage`ごと上へスライドアップし、次の元号候補`Stage`が下からせり上がる
   - せり上がる次の元号候補2つは初期Processのランダム取得を利用する
5. 完了した2つの元号候補は`store.history`の末尾に追加される

### Sequence

#### POST /vote

Header

```http
Accept: application/json
Content-type: application/json
```

Payload

```json
{
  "data": "${winner_identifier}/${loser_identifier}"
}
```

Sample request

```sh:curl
curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"data": "e8f95e09999e/49d85e18bb4e"}' http://localhost:3000/vote
```

## MEMO

- [x] /randomで返されるJSONのkeyをcamelCase化する
      - Gonではオプション設定でcamelCase化しているので`serializor`に任せる方が良い