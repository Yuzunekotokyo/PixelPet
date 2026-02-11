# Pixel Pet - ドット絵ペットウィジェットアプリ

かわいいドット絵のペットをホーム画面ウィジェットで飼育できるiOSアプリ

## 必要環境

- macOS
- Xcode 15+
- iOS 17+
- [XcodeGen](https://github.com/yonaskolb/XcodeGen)（オプション）

## セットアップ手順

### 方法1: XcodeGenを使用（推奨）

```bash
# XcodeGenがインストールされていない場合
brew install xcodegen

# プロジェクト生成
cd /path/to/PixelPet
xcodegen generate

# Xcodeで開く
open PixelPet.xcodeproj
```

### 方法2: 既存のXcodeプロジェクトを使用

```bash
open PixelPet.xcodeproj
```

### ビルド＆実行

1. **シミュレーターまたは実機を選択**
2. **▶️ Run ボタンをクリック**

## 開発フロー

```bash
# 機能ブランチを作成
git checkout -b feature/new-feature

# 変更をコミット
git add .
git commit -m "Add new feature"

# プッシュしてPR作成
git push -u origin feature/new-feature
gh pr create --title "Add new feature" --body "Description"
```

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

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

MIT License
