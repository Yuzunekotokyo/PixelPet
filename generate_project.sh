#!/bin/bash
# PixelPet Xcode Project Generator

PROJECT_DIR="/Users/kei/PixelPet"
cd "$PROJECT_DIR"

# Create Xcode project using swift package
mkdir -p PixelPetApp
cd PixelPetApp

# Initialize Swift package first, then we'll convert
swift package init --type executable --name PixelPet 2>/dev/null || true

echo "Project structure created. Use Xcode to create the full project."
