import ActivityKit
import WidgetKit
import SwiftUI

// MARK: - Live Activity Widget
struct PetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PetActivityAttributes.self) { context in
            // Lock Screen / Banner View
            LockScreenLiveActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded View
                DynamicIslandExpandedRegion(.leading) {
                    ExpandedLeadingView(context: context)
                }

                DynamicIslandExpandedRegion(.trailing) {
                    ExpandedTrailingView(context: context)
                }

                DynamicIslandExpandedRegion(.center) {
                    ExpandedCenterView(context: context)
                }

                DynamicIslandExpandedRegion(.bottom) {
                    ExpandedBottomView(context: context)
                }
            } compactLeading: {
                // Compact Left Side
                CompactLeadingView(context: context)
            } compactTrailing: {
                // Compact Right Side
                CompactTrailingView(context: context)
            } minimal: {
                // Minimal View (when other activities are present)
                MinimalView(context: context)
            }
        }
    }
}

// MARK: - Lock Screen View
struct LockScreenLiveActivityView: View {
    let context: ActivityViewContext<PetActivityAttributes>

    var petType: PetType {
        PetType(rawValue: context.state.petType) ?? .dog
    }

    var body: some View {
        HStack(spacing: 16) {
            // Pet sprite
            DynamicIslandPetView(petType: petType, frame: context.state.frame)
                .frame(width: 60, height: 60)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(petType.icon)
                    Text(context.attributes.petName)
                        .font(.headline)
                        .foregroundColor(.primary)
                }

                // Status bars
                HStack(spacing: 8) {
                    MiniStatusIndicator(icon: "fork.knife", value: context.state.hunger, color: .orange)
                    MiniStatusIndicator(icon: "heart.fill", value: context.state.happiness, color: .pink)
                    MiniStatusIndicator(icon: "bolt.fill", value: context.state.energy, color: .blue)
                }
            }

            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
    }
}

// MARK: - Dynamic Island Expanded Views
struct ExpandedLeadingView: View {
    let context: ActivityViewContext<PetActivityAttributes>

    var petType: PetType {
        PetType(rawValue: context.state.petType) ?? .dog
    }

    var body: some View {
        DynamicIslandPetView(petType: petType, frame: context.state.frame)
            .frame(width: 50, height: 50)
    }
}

struct ExpandedTrailingView: View {
    let context: ActivityViewContext<PetActivityAttributes>

    var petType: PetType {
        PetType(rawValue: context.state.petType) ?? .dog
    }

    var body: some View {
        VStack(alignment: .trailing, spacing: 2) {
            Text(petType.icon)
                .font(.title2)
            Text(context.attributes.petName)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct ExpandedCenterView: View {
    let context: ActivityViewContext<PetActivityAttributes>

    var body: some View {
        Text("Pixel Pet")
            .font(.caption2)
            .foregroundColor(.secondary)
    }
}

struct ExpandedBottomView: View {
    let context: ActivityViewContext<PetActivityAttributes>

    var body: some View {
        HStack(spacing: 16) {
            StatusBar(label: "Hunger", value: context.state.hunger, color: .orange)
            StatusBar(label: "Happy", value: context.state.happiness, color: .pink)
            StatusBar(label: "Energy", value: context.state.energy, color: .blue)
        }
        .padding(.horizontal)
    }

    struct StatusBar: View {
        let label: String
        let value: Double
        let color: Color

        var body: some View {
            VStack(spacing: 2) {
                Text(label)
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)

                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.gray.opacity(0.3))
                        RoundedRectangle(cornerRadius: 2)
                            .fill(color)
                            .frame(width: geometry.size.width * value)
                    }
                }
                .frame(height: 4)
            }
            .frame(width: 60)
        }
    }
}

// MARK: - Dynamic Island Compact Views
struct CompactLeadingView: View {
    let context: ActivityViewContext<PetActivityAttributes>

    var petType: PetType {
        PetType(rawValue: context.state.petType) ?? .dog
    }

    var body: some View {
        DynamicIslandPetView(petType: petType, frame: context.state.frame)
            .frame(width: 36, height: 36)
    }
}

struct CompactTrailingView: View {
    let context: ActivityViewContext<PetActivityAttributes>

    var petType: PetType {
        PetType(rawValue: context.state.petType) ?? .dog
    }

    var body: some View {
        Text(petType.icon)
            .font(.system(size: 16))
    }
}

// MARK: - Dynamic Island Minimal View
struct MinimalView: View {
    let context: ActivityViewContext<PetActivityAttributes>

    var petType: PetType {
        PetType(rawValue: context.state.petType) ?? .dog
    }

    var body: some View {
        DynamicIslandPetView(petType: petType, frame: context.state.frame)
            .frame(width: 24, height: 24)
    }
}

// MARK: - Mini Status Indicator
struct MiniStatusIndicator: View {
    let icon: String
    let value: Double
    let color: Color

    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: icon)
                .font(.system(size: 10))
                .foregroundColor(color)

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.gray.opacity(0.3))
                    RoundedRectangle(cornerRadius: 2)
                        .fill(color)
                        .frame(width: geometry.size.width * value)
                }
            }
            .frame(width: 30, height: 4)
        }
    }
}

// MARK: - Dynamic Island Pet View (Simplified for small sizes)
struct DynamicIslandPetView: View {
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
