#!/bin/bash
# PixelPet Xcode Project Auto-Generator
# Usage: ./create_project.sh

set -e

PROJECT_DIR="/Users/kei/PixelPet"
PROJECT_NAME="PixelPet"

echo "🐕 PixelPet プロジェクト作成スクリプト"
echo "======================================="

# Check if Xcode is installed
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Xcode が見つかりません。App Store からインストールしてください。"
    exit 1
fi

echo "✅ Xcode 確認完了"

# Create project using xcodegen or manual method
echo ""
echo "📝 次の手順で Xcode プロジェクトを作成してください："
echo ""
echo "1. Xcode を開く"
echo "   open -a Xcode"
echo ""
echo "2. 「Create New Project」→「iOS」→「App」"
echo ""
echo "3. 設定:"
echo "   - Product Name: PixelPet"
echo "   - Organization Identifier: com.yourname"
echo "   - Interface: SwiftUI"
echo "   - Language: Swift"
echo ""
echo "4. 保存先: $PROJECT_DIR を選択"
echo ""
echo "5. プロジェクト作成後、以下のファイルを追加:"
echo "   - Shared/PetState.swift"
echo "   - Shared/PixelPetView.swift"
echo ""
echo "6. Widget Extension を追加:"
echo "   File → New → Target → Widget Extension"
echo "   - Name: PixelPetWidget"
echo "   - 「Include Configuration App Intent」のチェックを外す"
echo ""
echo "7. ウィジェットファイルを置き換え"
echo ""
echo "======================================="
echo ""

# Open Xcode
read -p "Xcode を開きますか？ (y/n): " answer
if [ "$answer" = "y" ]; then
    open -a Xcode
fi
