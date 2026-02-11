import WidgetKit
import SwiftUI

// MARK: - Timeline Provider
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> PetEntry {
        PetEntry(date: Date(), frame: 0, petType: .dog, hunger: 0.7, happiness: 0.8, energy: 0.6)
    }

    func getSnapshot(in context: Context, completion: @escaping (PetEntry) -> Void) {
        let entry = PetEntry(date: Date(), frame: 0, petType: .dog, hunger: 0.7, happiness: 0.8, energy: 0.6)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<PetEntry>) -> Void) {
        var entries: [PetEntry] = []
        let currentDate = Date()

        // Load saved pet type
        let savedData = PetDataManager.loadPetState()

        // Generate entries for animation
        for i in 0..<20 {
            let entryDate = Calendar.current.date(byAdding: .second, value: i, to: currentDate)!
            let frame = i % 4
            let entry = PetEntry(
                date: entryDate,
                frame: frame,
                petType: savedData.petType,
                hunger: savedData.hunger > 0 ? savedData.hunger : 0.7,
                happiness: savedData.happiness > 0 ? savedData.happiness : 0.8,
                energy: savedData.energy > 0 ? savedData.energy : 0.6
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
    let petType: PetType
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
                StaticPixelPetView(petType: entry.petType, frame: entry.frame)
                    .frame(width: 80, height: 80)

                HStack(spacing: 4) {
                    Text(entry.petType.icon)
                        .font(.system(size: 12))
                    Text(entry.petType.displayName)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(.brown)
                }
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
                StaticPixelPetView(petType: entry.petType, frame: entry.frame)
                    .frame(width: 100, height: 100)

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(entry.petType.icon)
                        Text(entry.petType.displayName)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.brown)
                    }

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
    PetEntry(date: .now, frame: 0, petType: .dog, hunger: 0.7, happiness: 0.8, energy: 0.6)
    PetEntry(date: .now, frame: 1, petType: .demon, hunger: 0.7, happiness: 0.8, energy: 0.6)
    PetEntry(date: .now, frame: 2, petType: .dragon, hunger: 0.7, happiness: 0.8, energy: 0.6)
}
