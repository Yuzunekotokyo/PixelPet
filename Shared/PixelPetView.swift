import SwiftUI

// MARK: - Pixel Pet View (Animated Sprite)
struct PixelPetView: View {
    @ObservedObject var petState: PetState

    // Pixel art colors
    let bodyColor = Color(red: 0.6, green: 0.4, blue: 0.2)      // Brown
    let lightColor = Color(red: 0.8, green: 0.6, blue: 0.4)     // Light brown
    let eyeColor = Color.black
    let noseColor = Color(red: 0.3, green: 0.2, blue: 0.1)      // Dark brown
    let cheekColor = Color(red: 1.0, green: 0.7, blue: 0.7)     // Pink

    var body: some View {
        GeometryReader { geometry in
            let pixelSize = geometry.size.width / 16

            Canvas { context, size in
                // Draw pixel art dog based on current frame
                drawPixelPet(context: context, pixelSize: pixelSize, frame: petState.currentFrame)
            }
        }
    }

    // MARK: - Pixel Art Drawing
    func drawPixelPet(context: GraphicsContext, pixelSize: CGFloat, frame: Int) {
        // 16x16 pixel grid for the pet
        // Animation frames: idle breathing / tail wag

        let petSprite = getSprite(for: frame)

        for (rowIndex, row) in petSprite.enumerated() {
            for (colIndex, pixel) in row.enumerated() {
                let color = colorForPixel(pixel)
                if let color = color {
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

    // MARK: - Sprite Frames
    func getSprite(for frame: Int) -> [[Character]] {
        // Legend:
        // . = transparent
        // B = body (brown)
        // L = light (light brown)
        // E = eye (black)
        // N = nose (dark brown)
        // C = cheek (pink)
        // W = white

        let sprites: [[[Character]]] = [
            // Frame 0: Idle
            [
                "................".map{$0},
                "................".map{$0},
                "...BB....BB.....".map{$0},
                "..BBBB..BBBB....".map{$0},
                "..BLLLBBBLLL....".map{$0},
                "..LLLLLLLLLL....".map{$0},
                "..LEWLLEWLLL....".map{$0},
                "..LLLLLLLLL.....".map{$0},
                "...LLLNLLL......".map{$0},
                "....LLLLL.......".map{$0},
                "...BBBBBBB......".map{$0},
                "..BBLLLLLBB.....".map{$0},
                "..BLLLLLLLLB....".map{$0},
                "..BLL..LLLLB....".map{$0},
                "...BB...BB......".map{$0},
                "................".map{$0},
            ],
            // Frame 1: Blink
            [
                "................".map{$0},
                "................".map{$0},
                "...BB....BB.....".map{$0},
                "..BBBB..BBBB....".map{$0},
                "..BLLLBBBLLL....".map{$0},
                "..LLLLLLLLLL....".map{$0},
                "..LEELLEELLL....".map{$0},
                "..LLLLLLLLL.....".map{$0},
                "...LLLNLLL......".map{$0},
                "....LLLLL.......".map{$0},
                "...BBBBBBB......".map{$0},
                "..BBLLLLLBB.....".map{$0},
                "..BLLLLLLLLB....".map{$0},
                "..BLL..LLLLB....".map{$0},
                "...BB...BB......".map{$0},
                "................".map{$0},
            ],
            // Frame 2: Tail wag left
            [
                "................".map{$0},
                "................".map{$0},
                "...BB....BB.....".map{$0},
                "..BBBB..BBBB....".map{$0},
                "..BLLLBBBLLL....".map{$0},
                "..LLLLLLLLLL....".map{$0},
                "..LEWLLEWLLL....".map{$0},
                "..LLLLLLLLL.....".map{$0},
                "...LLLNLLL......".map{$0},
                "....LLLLL.......".map{$0},
                "...BBBBBBB......".map{$0},
                "..BBLLLLLBBB....".map{$0},
                "..BLLLLLLLLB....".map{$0},
                "..BLL..LLLLB....".map{$0},
                "...BB...BB......".map{$0},
                "................".map{$0},
            ],
            // Frame 3: Tail wag right
            [
                "................".map{$0},
                "................".map{$0},
                "...BB....BB.....".map{$0},
                "..BBBB..BBBB....".map{$0},
                "..BLLLBBBLLL....".map{$0},
                "..LLLLLLLLLL....".map{$0},
                "..LEWLLEWLLL....".map{$0},
                "..LLLLLLLLL.....".map{$0},
                "...LLLNLLL......".map{$0},
                "....LLLLL.......".map{$0},
                "...BBBBBBB......".map{$0},
                ".BBBLLLLLBB.....".map{$0},
                "..BLLLLLLLLB....".map{$0},
                "..BLL..LLLLB....".map{$0},
                "...BB...BB......".map{$0},
                "................".map{$0},
            ],
        ]

        return sprites[frame % sprites.count]
    }

    // MARK: - Color Mapping
    func colorForPixel(_ char: Character) -> Color? {
        switch char {
        case "B": return bodyColor
        case "L": return lightColor
        case "E": return eyeColor
        case "N": return noseColor
        case "C": return cheekColor
        case "W": return .white
        default: return nil
        }
    }
}

// MARK: - Preview
struct PixelPetView_Previews: PreviewProvider {
    static var previews: some View {
        PixelPetView(petState: PetState())
            .frame(width: 160, height: 160)
            .background(Color.white)
    }
}
