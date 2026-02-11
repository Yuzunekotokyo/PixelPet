import SwiftUI

// MARK: - Pet Type Enum
enum PetType: String, CaseIterable, Identifiable {
    case dog = "dog"
    case demon = "demon"
    case dragon = "dragon"
    case slime = "slime"
    case ghost = "ghost"
    case fairy = "fairy"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .dog: return "いぬ"
        case .demon: return "あくま"
        case .dragon: return "ドラゴン"
        case .slime: return "スライム"
        case .ghost: return "ゴースト"
        case .fairy: return "ようせい"
        }
    }

    var icon: String {
        switch self {
        case .dog: return "🐕"
        case .demon: return "😈"
        case .dragon: return "🐉"
        case .slime: return "🟢"
        case .ghost: return "👻"
        case .fairy: return "🧚"
        }
    }
}

// MARK: - Pet Sprites
struct PetSprites {

    // Color palette for each pet type
    static func colors(for type: PetType) -> [Character: Color] {
        switch type {
        case .dog:
            return [
                "B": Color(red: 0.6, green: 0.4, blue: 0.2),      // Brown body
                "L": Color(red: 0.8, green: 0.6, blue: 0.4),      // Light brown
                "E": Color.black,                                   // Eye
                "N": Color(red: 0.3, green: 0.2, blue: 0.1),      // Nose
                "W": Color.white,
            ]
        case .demon:
            return [
                "B": Color(red: 0.5, green: 0.1, blue: 0.1),      // Dark red body
                "L": Color(red: 0.8, green: 0.2, blue: 0.2),      // Light red
                "E": Color.yellow,                                  // Yellow eyes
                "H": Color(red: 0.3, green: 0.0, blue: 0.0),      // Horn (darker)
                "W": Color.white,
                "F": Color(red: 1.0, green: 0.5, blue: 0.0),      // Fire/orange
            ]
        case .dragon:
            return [
                "B": Color(red: 0.2, green: 0.5, blue: 0.3),      // Green body
                "L": Color(red: 0.4, green: 0.7, blue: 0.5),      // Light green
                "E": Color(red: 1.0, green: 0.3, blue: 0.0),      // Orange eyes
                "H": Color(red: 0.1, green: 0.3, blue: 0.2),      // Horn/spike
                "W": Color.white,
                "F": Color(red: 1.0, green: 0.5, blue: 0.0),      // Fire
                "Y": Color.yellow,                                  // Yellow belly
            ]
        case .slime:
            return [
                "B": Color(red: 0.2, green: 0.6, blue: 0.8),      // Blue body
                "L": Color(red: 0.4, green: 0.8, blue: 1.0),      // Light blue
                "E": Color.black,                                   // Eye
                "W": Color.white,
                "S": Color(red: 0.6, green: 0.9, blue: 1.0),      // Shine
            ]
        case .ghost:
            return [
                "B": Color(red: 0.9, green: 0.9, blue: 0.95),     // White body
                "L": Color(red: 0.7, green: 0.7, blue: 0.8),      // Shadow
                "E": Color.black,                                   // Eye
                "W": Color.white,
                "P": Color(red: 0.6, green: 0.5, blue: 0.8),      // Purple tint
            ]
        case .fairy:
            return [
                "B": Color(red: 1.0, green: 0.8, blue: 0.9),      // Pink body
                "L": Color(red: 1.0, green: 0.9, blue: 0.95),     // Light pink
                "E": Color(red: 0.3, green: 0.3, blue: 0.8),      // Blue eyes
                "W": Color.white,
                "G": Color(red: 0.8, green: 1.0, blue: 0.8),      // Wing green
                "Y": Color.yellow,                                  // Sparkle
                "H": Color(red: 1.0, green: 0.9, blue: 0.5),      // Hair/golden
            ]
        }
    }

    // MARK: - Dog Sprites
    static let dogSprites: [[[Character]]] = [
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

    // MARK: - Demon Sprites (悪魔)
    static let demonSprites: [[[Character]]] = [
        // Frame 0: Idle
        [
            "..H........H....".map{$0},
            "..HH......HH....".map{$0},
            "...HBBBBBBH.....".map{$0},
            "...BBBBBBBB.....".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "..BBELBBLEBBB...".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "...BBLLLLBB.....".map{$0},
            "...BBLWWLBB.....".map{$0},
            "....BBBBBB......".map{$0},
            "...BBBBBBBB.....".map{$0},
            "..BBBLLLLLBB....".map{$0},
            "..BB.BBBB.BB....".map{$0},
            "..B...BB...B....".map{$0},
            ".FF...FF...FF...".map{$0},
            "................".map{$0},
        ],
        // Frame 1: Blink
        [
            "..H........H....".map{$0},
            "..HH......HH....".map{$0},
            "...HBBBBBBH.....".map{$0},
            "...BBBBBBBB.....".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "..BBEEBBEEBBB...".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "...BBLLLLBB.....".map{$0},
            "...BBLWWLBB.....".map{$0},
            "....BBBBBB......".map{$0},
            "...BBBBBBBB.....".map{$0},
            "..BBBLLLLLBB....".map{$0},
            "..BB.BBBB.BB....".map{$0},
            "..B...BB...B....".map{$0},
            ".FF...FF...FF...".map{$0},
            "................".map{$0},
        ],
        // Frame 2: Wings up
        [
            "..H........H....".map{$0},
            "..HH......HH....".map{$0},
            "...HBBBBBBH.....".map{$0},
            "...BBBBBBBB.....".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "..BBELBBLEBBB...".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "...BBLLLLBB.....".map{$0},
            "F..BBLWWLBB..F..".map{$0},
            ".F..BBBBBB..F...".map{$0},
            "..FBBBBBBBBF....".map{$0},
            "..BBBLLLLLBB....".map{$0},
            "..BB.BBBB.BB....".map{$0},
            "..B...BB...B....".map{$0},
            "......FF........".map{$0},
            "................".map{$0},
        ],
        // Frame 3: Fire
        [
            "..H........H....".map{$0},
            "..HH......HH....".map{$0},
            "...HBBBBBBH.....".map{$0},
            "...BBBBBBBB.....".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "..BBELBBLEBBB...".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "...BBLLLLBB.....".map{$0},
            "...BBLWWLBB.....".map{$0},
            "....BBBBBB......".map{$0},
            "...BBBBBBBB.....".map{$0},
            "..BBBLLLLLBB....".map{$0},
            "..BB.BBBB.BB....".map{$0},
            "..B...BB...B....".map{$0},
            "..F..FFFF..F....".map{$0},
            ".FFF.F..F.FFF...".map{$0},
        ],
    ]

    // MARK: - Dragon Sprites (ドラゴン)
    static let dragonSprites: [[[Character]]] = [
        // Frame 0: Idle
        [
            "......HH........".map{$0},
            ".....HBBH.......".map{$0},
            "....HBBBBH......".map{$0},
            "...BBBBBBBB.....".map{$0},
            "..BBBELBLEBBB...".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "...BBBBBBB......".map{$0},
            "....BYYYB.......".map{$0},
            "...BBYYYBB......".map{$0},
            "..BBBYYYBBB.....".map{$0},
            ".BBBB.B.BBBB....".map{$0},
            ".BB.......BB....".map{$0},
            ".B.........B....".map{$0},
            "................".map{$0},
            "..........BBB...".map{$0},
            ".........BBBBB..".map{$0},
        ],
        // Frame 1: Blink
        [
            "......HH........".map{$0},
            ".....HBBH.......".map{$0},
            "....HBBBBH......".map{$0},
            "...BBBBBBBB.....".map{$0},
            "..BBBEEBLEEBB...".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "...BBBBBBB......".map{$0},
            "....BYYYB.......".map{$0},
            "...BBYYYBB......".map{$0},
            "..BBBYYYBBB.....".map{$0},
            ".BBBB.B.BBBB....".map{$0},
            ".BB.......BB....".map{$0},
            ".B.........B....".map{$0},
            "................".map{$0},
            "..........BBB...".map{$0},
            ".........BBBBB..".map{$0},
        ],
        // Frame 2: Tail swing
        [
            "......HH........".map{$0},
            ".....HBBH.......".map{$0},
            "....HBBBBH......".map{$0},
            "...BBBBBBBB.....".map{$0},
            "..BBBELBLEBBB...".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "...BBBBBBB......".map{$0},
            "....BYYYB.......".map{$0},
            "...BBYYYBB......".map{$0},
            "..BBBYYYBBB.....".map{$0},
            ".BBBB.B.BBBB....".map{$0},
            ".BB.......BB....".map{$0},
            ".B.........B....".map{$0},
            "................".map{$0},
            ".........BBB....".map{$0},
            "........BBBBB...".map{$0},
        ],
        // Frame 3: Fire breath
        [
            "......HH........".map{$0},
            ".....HBBH.......".map{$0},
            "....HBBBBH..FF..".map{$0},
            "...BBBBBBBBFFFF.".map{$0},
            "..BBBELBLEBBBFF.".map{$0},
            "..BBBBBBBBBB.F..".map{$0},
            "...BBBBBBB......".map{$0},
            "....BYYYB.......".map{$0},
            "...BBYYYBB......".map{$0},
            "..BBBYYYBBB.....".map{$0},
            ".BBBB.B.BBBB....".map{$0},
            ".BB.......BB....".map{$0},
            ".B.........B....".map{$0},
            "................".map{$0},
            "..........BBB...".map{$0},
            ".........BBBBB..".map{$0},
        ],
    ]

    // MARK: - Slime Sprites (スライム)
    static let slimeSprites: [[[Character]]] = [
        // Frame 0: Idle
        [
            "................".map{$0},
            "................".map{$0},
            "................".map{$0},
            ".....SSSS.......".map{$0},
            "....SLLLLB......".map{$0},
            "...SLLLLLBB.....".map{$0},
            "...BLLLLLLB.....".map{$0},
            "..BLEWBLEWLB....".map{$0},
            "..BLLLBBLLLB....".map{$0},
            "..BBLLLLLLBB....".map{$0},
            "...BBLLLLBB.....".map{$0},
            "...BBBLLBBB.....".map{$0},
            "....BBBBBB......".map{$0},
            ".....BBBB.......".map{$0},
            "................".map{$0},
            "................".map{$0},
        ],
        // Frame 1: Blink
        [
            "................".map{$0},
            "................".map{$0},
            "................".map{$0},
            ".....SSSS.......".map{$0},
            "....SLLLLB......".map{$0},
            "...SLLLLLBB.....".map{$0},
            "...BLLLLLLB.....".map{$0},
            "..BLEEBBEELB....".map{$0},
            "..BLLLBBLLLB....".map{$0},
            "..BBLLLLLLBB....".map{$0},
            "...BBLLLLBB.....".map{$0},
            "...BBBLLBBB.....".map{$0},
            "....BBBBBB......".map{$0},
            ".....BBBB.......".map{$0},
            "................".map{$0},
            "................".map{$0},
        ],
        // Frame 2: Squish down
        [
            "................".map{$0},
            "................".map{$0},
            "................".map{$0},
            "................".map{$0},
            ".....SSSS.......".map{$0},
            "...SSLLLLBB.....".map{$0},
            "..SLLLLLLLLB....".map{$0},
            "..BLEWBBLEWLB...".map{$0},
            "..BLLLBBBLLLB...".map{$0},
            "..BBBLLLLLLBBB..".map{$0},
            "...BBBBLLBBBB...".map{$0},
            "....BBBBBBBB....".map{$0},
            ".....BBBBBB.....".map{$0},
            "................".map{$0},
            "................".map{$0},
            "................".map{$0},
        ],
        // Frame 3: Bounce up
        [
            "................".map{$0},
            ".....SSSS.......".map{$0},
            "....SLLLLB......".map{$0},
            "...SLLLLLBB.....".map{$0},
            "...BLLLLLLB.....".map{$0},
            "..BLEWBLEWLB....".map{$0},
            "..BLLLBBLLLB....".map{$0},
            "..BBLLLLLLBB....".map{$0},
            "...BBLLLLBB.....".map{$0},
            "...BBBLLBBB.....".map{$0},
            "....BBBBBB......".map{$0},
            ".....BBBB.......".map{$0},
            "................".map{$0},
            "................".map{$0},
            "................".map{$0},
            "................".map{$0},
        ],
    ]

    // MARK: - Ghost Sprites (ゴースト)
    static let ghostSprites: [[[Character]]] = [
        // Frame 0: Idle
        [
            "................".map{$0},
            ".....BBBB.......".map{$0},
            "....BBBBBB......".map{$0},
            "...BBBBBBBB.....".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "..BBELBBLEBBB...".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "...BLLLLLBB.....".map{$0},
            "...BBBBBBBB.....".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "..BBLBBLBBLB....".map{$0},
            "...B..B..B......".map{$0},
            "................".map{$0},
            "................".map{$0},
            "................".map{$0},
        ],
        // Frame 1: Blink
        [
            "................".map{$0},
            ".....BBBB.......".map{$0},
            "....BBBBBB......".map{$0},
            "...BBBBBBBB.....".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "..BBEEBBEEBB....".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "...BLLLLLBB.....".map{$0},
            "...BBBBBBBB.....".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "..BBLBBLBBLB....".map{$0},
            "...B..B..B......".map{$0},
            "................".map{$0},
            "................".map{$0},
            "................".map{$0},
        ],
        // Frame 2: Float up
        [
            ".....BBBB.......".map{$0},
            "....BBBBBB......".map{$0},
            "...BBBBBBBB.....".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "..BBELBBLEBBB...".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "...BLLLLLBB.....".map{$0},
            "...BBBBBBBB.....".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "..BBLBBLBBLB....".map{$0},
            "...B..B..B......".map{$0},
            "................".map{$0},
            "................".map{$0},
            "................".map{$0},
            "................".map{$0},
        ],
        // Frame 3: Float down
        [
            "................".map{$0},
            "................".map{$0},
            ".....BBBB.......".map{$0},
            "....BBBBBB......".map{$0},
            "...BBBBBBBB.....".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "..BBELBBLEBBB...".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "...BLLLLLBB.....".map{$0},
            "...BBBBBBBB.....".map{$0},
            "..BBBBBBBBBB....".map{$0},
            "..BBLBBLBBLB....".map{$0},
            "...B..B..B......".map{$0},
            "................".map{$0},
            "................".map{$0},
        ],
    ]

    // MARK: - Fairy Sprites (ようせい)
    static let fairySprites: [[[Character]]] = [
        // Frame 0: Idle
        [
            "......YY........".map{$0},
            ".....YHHH.......".map{$0},
            "....HHHHHH......".map{$0},
            "....BBBBBB......".map{$0},
            "...BBELBLEBBB...".map{$0},
            "...BBBLLBBB.....".map{$0},
            "....BLLLLB......".map{$0},
            "..G.BBBBBB.G....".map{$0},
            ".GGG.BBBB.GGG...".map{$0},
            ".GG...BB...GG...".map{$0},
            ".G....BB....G...".map{$0},
            "......BB........".map{$0},
            ".....B..B.......".map{$0},
            "................".map{$0},
            "................".map{$0},
            "................".map{$0},
        ],
        // Frame 1: Blink
        [
            "......YY........".map{$0},
            ".....YHHH.......".map{$0},
            "....HHHHHH......".map{$0},
            "....BBBBBB......".map{$0},
            "...BBEEBBEEBB...".map{$0},
            "...BBBLLBBB.....".map{$0},
            "....BLLLLB......".map{$0},
            "..G.BBBBBB.G....".map{$0},
            ".GGG.BBBB.GGG...".map{$0},
            ".GG...BB...GG...".map{$0},
            ".G....BB....G...".map{$0},
            "......BB........".map{$0},
            ".....B..B.......".map{$0},
            "................".map{$0},
            "................".map{$0},
            "................".map{$0},
        ],
        // Frame 2: Wings up
        [
            "......YY........".map{$0},
            ".....YHHH.......".map{$0},
            "....HHHHHH......".map{$0},
            "....BBBBBB......".map{$0},
            "...BBELBLEBBB...".map{$0},
            "...BBBLLBBB.....".map{$0},
            ".GG.BLLLLB.GG...".map{$0},
            ".GGG.BBBBBB.GGG.".map{$0},
            "..G..BBBB..G....".map{$0},
            "......BB........".map{$0},
            "......BB........".map{$0},
            ".....B..B.......".map{$0},
            "................".map{$0},
            "................".map{$0},
            "................".map{$0},
            "................".map{$0},
        ],
        // Frame 3: Sparkle
        [
            "..Y...YY....Y...".map{$0},
            ".....YHHH.......".map{$0},
            "....HHHHHH......".map{$0},
            "Y...BBBBBB...Y..".map{$0},
            "...BBELBLEBBB...".map{$0},
            "...BBBLLBBB.....".map{$0},
            "....BLLLLB......".map{$0},
            "..G.BBBBBB.G....".map{$0},
            ".GGG.BBBB.GGG...".map{$0},
            ".GG...BB...GG...".map{$0},
            ".G....BB....G...".map{$0},
            "......BB........".map{$0},
            ".....B..B.......".map{$0},
            "..Y..........Y..".map{$0},
            "................".map{$0},
            "................".map{$0},
        ],
    ]

    // MARK: - Get sprites for pet type
    static func sprites(for type: PetType) -> [[[Character]]] {
        switch type {
        case .dog: return dogSprites
        case .demon: return demonSprites
        case .dragon: return dragonSprites
        case .slime: return slimeSprites
        case .ghost: return ghostSprites
        case .fairy: return fairySprites
        }
    }
}
