import SwiftUI

// MARK: - Pixel Pet View (Animated Sprite)
struct PixelPetView: View {
    @ObservedObject var petState: PetState

    var body: some View {
        GeometryReader { geometry in
            let pixelSize = geometry.size.width / 16

            Canvas { context, size in
                drawPixelPet(context: context, pixelSize: pixelSize, frame: petState.currentFrame, petType: petState.petType)
            }
        }
    }

    // MARK: - Pixel Art Drawing
    func drawPixelPet(context: GraphicsContext, pixelSize: CGFloat, frame: Int, petType: PetType) {
        let sprites = PetSprites.sprites(for: petType)
        let colors = PetSprites.colors(for: petType)
        let petSprite = sprites[frame % sprites.count]

        for (rowIndex, row) in petSprite.enumerated() {
            for (colIndex, pixel) in row.enumerated() {
                if let color = colors[pixel] {
                    let rect = CGRect(
                        x: CGFloat(colIndex) * pixelSize,
                        y: CGFloat(rowIndex) * pixelSize,
                        width: pixelSize + 0.5,
                        height: pixelSize + 0.5
                    )
                    context.fill(Path(rect), with: .color(color))
                }
            }
        }
    }
}

// MARK: - Static Pixel Pet View (for Widget without PetState)
struct StaticPixelPetView: View {
    let petType: PetType
    let frame: Int

    var body: some View {
        GeometryReader { geometry in
            let pixelSize = geometry.size.width / 16

            Canvas { context, size in
                let sprites = PetSprites.sprites(for: petType)
                let colors = PetSprites.colors(for: petType)
                let petSprite = sprites[frame % sprites.count]

                for (rowIndex, row) in petSprite.enumerated() {
                    for (colIndex, pixel) in row.enumerated() {
                        if let color = colors[pixel] {
                            let rect = CGRect(
                                x: CGFloat(colIndex) * pixelSize,
                                y: CGFloat(rowIndex) * pixelSize,
                                width: pixelSize + 0.5,
                                height: pixelSize + 0.5
                            )
                            context.fill(Path(rect), with: .color(color))
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct PixelPetView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            ForEach(PetType.allCases) { type in
                HStack {
                    Text(type.icon)
                    StaticPixelPetView(petType: type, frame: 0)
                        .frame(width: 80, height: 80)
                        .background(Color.white)
                    Text(type.displayName)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
    }
}
