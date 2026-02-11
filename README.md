# Pixel Pet - ドット絵ペットウィジェットアプリ

かわいいドット絵のペットをホーム画面ウィジェットで飼育できるiOSアプリ

## セットアップ手順

### 1. Xcodeでプロジェクトを作成

1. **Xcodeを開く**
2. **「Create New Project」をクリック**
3. **「iOS」→「App」を選択 → Next**
4. 以下を入力:
   - Product Name: `PixelPet`
   - Organization Identifier: `com.yourname`
   - Interface: `SwiftUI`
   - Language: `Swift`
5. **保存先を `/Users/kei/PixelPet` に設定**（既存ファイルを上書き）
6. **Create**

### 2. ソースファイルをプロジェクトに追加

作成したプロジェクトに以下のファイルをドラッグ＆ドロップ:

**メインアプリ用:**
- `PixelPet/PixelPetApp.swift`（既存のものを置き換え）
- `PixelPet/ContentView.swift`（既存のものを置き換え）

**共有ファイル（新規追加）:**
- `Shared/PetState.swift`
- `Shared/PixelPetView.swift`

### 3. Widget Extension を追加

1. **File → New → Target**
2. **「Widget Extension」を選択 → Next**
3. **Product Name**: `PixelPetWidget`
4. **「Include Configuration App Intent」のチェックを外す**
5. **Finish → 「Activate」をクリック**

### 4. ウィジェットファイルを置き換え

生成されたウィジェットファイルを以下で置き換え:
- `PixelPetWidget/PixelPetWidget.swift`
- `PixelPetWidget/PixelPetWidgetBundle.swift`

### 5. ビルド＆実行

1. **シミュレーターまたは実機を選択**
2. **▶️ Run ボタンをクリック**

## 機能

- ドット絵の犬がアニメーションで動く
- ホーム画面ウィジェット（小・中サイズ）
- 育成機能（エサやり、なでる、睡眠）
- ステータスバー（空腹度、幸福度、エネルギー）

## ファイル構成

```
PixelPet/
├── PixelPet/
│   ├── PixelPetApp.swift      # アプリエントリーポイント
│   └── ContentView.swift       # メイン画面
├── Shared/
│   ├── PetState.swift          # ペット状態管理
│   └── PixelPetView.swift      # ドット絵描画
├── PixelPetWidget/
│   ├── PixelPetWidget.swift    # ウィジェット本体
│   └── PixelPetWidgetBundle.swift
└── README.md
```

## カスタマイズ

### 別の動物に変更
`PixelPetView.swift` の `getSprite()` メソッドでドット絵を編集

### 色の変更
`bodyColor`, `lightColor` などの定数を変更
