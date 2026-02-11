import WidgetKit
import SwiftUI

// MARK: - Timeline Provider
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> PetEntry {
        PetEntry(date: Date(), frame: 0, hunger: 0.7, happiness: 0.8, energy: 0.6)
    }

    func getSnapshot(in context: Context, completion: @escaping (PetEntry) -> Void) {
        let entry = PetEntry(date: Date(), frame: 0, hunger: 0.7, happiness: 0.8, energy: 0.6)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<PetEntry>) -> Void) {
        var entries: [PetEntry] = []
        let currentDate = Date()

        // Generate entries for animation (every 0.5 seconds for 10 seconds, then refresh)
        for i in 0..<20 {
            let entryDate = Calendar.current.date(byAdding: .second, value: i, to: currentDate)!
            let frame = i % 4
            let entry = PetEntry(
                date: entryDate,
                frame: frame,
                hunger: 0.7,
                happiness: 0.8,
                energy: 0.6
            )
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

// MARK: - Timeline Entry
struct PetEntry: TimelineEntry {
    let date: Date
    let frame: Int
    let hunger: Double
    let happiness: Double
    let energy: Double
}

// MARK: - Widget View
struct PixelPetWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case .systemMedium:
            MediumWidgetView(entry: entry)
        default:
            SmallWidgetView(entry: entry)
        }
    }
}

// MARK: - Small Widget
struct SmallWidgetView: View {
    let entry: PetEntry

    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(Color(red: 0.95, green: 0.95, blue: 0.92))

            VStack(spacing: 4) {
                WidgetPixelPetView(frame: entry.frame)
                    .frame(width: 80, height: 80)

                Text("Pixel")
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(.brown)
            }
        }
    }
}

// MARK: - Medium Widget
struct MediumWidgetView: View {
    let entry: PetEntry

    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(Color(red: 0.95, green: 0.95, blue: 0.92))

            HStack(spacing: 20) {
                WidgetPixelPetView(frame: entry.frame)
                    .frame(width: 100, height: 100)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Pixel")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.brown)

                    WidgetStatusBar(label: "Hunger", value: entry.hunger, color: .orange)
                    WidgetStatusBar(label: "Happy", value: entry.happiness, color: .pink)
                    WidgetStatusBar(label: "Energy", value: entry.energy, color: .blue)
                }
            }
            .padding()
        }
    }
}

// MARK: - Widget Status Bar
struct WidgetStatusBar: View {
    let label: String
    let value: Double
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.system(size: 10))
                .foregroundColor(.gray)

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.gray.opacity(0.3))
                    RoundedRectangle(cornerRadius: 3)
                        .fill(color)
                        .frame(width: geometry.size.width * value)
                }
            }
            .frame(height: 8)
        }
        .frame(width: 100)
    }
}

// MARK: - Widget Pixel Pet View
struct WidgetPixelPetView: View {
    let frame: Int

    let bodyColor = Color(red: 0.6, green: 0.4, blue: 0.2)
    let lightColor = Color(red: 0.8, green: 0.6, blue: 0.4)
    let eyeColor = Color.black
    let noseColor = Color(red: 0.3, green: 0.2, blue: 0.1)

    var body: some View {
        GeometryReader { geometry in
            let pixelSize = geometry.size.width / 16

            Canvas { context, size in
                let sprite = getSprite(for: frame)
                for (rowIndex, row) in sprite.enumerated() {
                    for (colIndex, pixel) in row.enumerated() {
                        if let color = colorForPixel(pixel) {
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

    func getSprite(for frame: Int) -> [[Character]] {
        let sprites: [[[Character]]] = [
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

    func colorForPixel(_ char: Character) -> Color? {
        switch char {
        case "B": return bodyColor
        case "L": return lightColor
        case "E": return eyeColor
        case "N": return noseColor
        case "W": return .white
        default: return nil
        }
    }
}

// MARK: - Widget Configuration
struct PixelPetWidget: Widget {
    let kind: String = "PixelPetWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            PixelPetWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Pixel Pet")
        .description("Your cute pixel pet companion!")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Preview
#Preview(as: .systemSmall) {
    PixelPetWidget()
} timeline: {
    PetEntry(date: .now, frame: 0, hunger: 0.7, happiness: 0.8, energy: 0.6)
    PetEntry(date: .now, frame: 1, hunger: 0.7, happiness: 0.8, energy: 0.6)
}
