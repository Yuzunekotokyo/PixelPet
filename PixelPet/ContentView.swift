import SwiftUI
import ActivityKit

struct ContentView: View {
    @StateObject private var petState = PetState()
    @StateObject private var activityManager = PetActivityManager.shared
    @State private var showingPetSelector = false

    var body: some View {
        ZStack {
            // Background
            Color(red: 0.95, green: 0.95, blue: 0.92)
                .ignoresSafeArea()

            VStack(spacing: 30) {
                // Title
                Text("Pixel Pet")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.brown)

                // Pet Display
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(radius: 5)

                    VStack {
                        // Animated Pet
                        PixelPetView(petState: petState)
                            .frame(width: 120, height: 120)

                        // Pet Name with Icon
                        HStack {
                            Text(petState.petType.icon)
                            Text(petState.name)
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                }
                .frame(width: 200, height: 200)
                .onTapGesture {
                    showingPetSelector = true
                }

                // Pet Selector Button
                Button(action: { showingPetSelector = true }) {
                    HStack {
                        Image(systemName: "pawprint.fill")
                        Text("キャラクター変更")
                    }
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.brown)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.brown, lineWidth: 2)
                    )
                }

                // Status Bars
                VStack(spacing: 15) {
                    StatusBar(label: "Hunger", value: petState.hunger, color: .orange)
                    StatusBar(label: "Happiness", value: petState.happiness, color: .pink)
                    StatusBar(label: "Energy", value: petState.energy, color: .blue)
                }
                .padding(.horizontal, 40)

                // Action Buttons
                HStack(spacing: 20) {
                    ActionButton(icon: "fork.knife", label: "Feed") {
                        petState.feed()
                    }

                    ActionButton(icon: "hand.raised.fill", label: "Pet") {
                        petState.pet()
                    }

                    ActionButton(icon: "moon.fill", label: "Sleep") {
                        petState.sleep()
                    }
                }

                // Dynamic Island Toggle
                DynamicIslandToggleButton(
                    isRunning: activityManager.isActivityRunning,
                    petState: petState
                )
                .padding(.top, 10)

                Spacer()
            }
            .padding(.top, 50)
        }
        .sheet(isPresented: $showingPetSelector) {
            PetSelectorView(petState: petState)
        }
    }
}

// MARK: - Pet Selector View
struct PetSelectorView: View {
    @ObservedObject var petState: PetState
    @Environment(\.dismiss) var dismiss

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(PetType.allCases) { type in
                        PetTypeCard(
                            type: type,
                            isSelected: petState.petType == type
                        ) {
                            petState.changePetType(type)
                            dismiss()
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("キャラクター選択")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("閉じる") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Pet Type Card
struct PetTypeCard: View {
    let type: PetType
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(isSelected ? Color.brown.opacity(0.2) : Color.white)
                        .shadow(radius: isSelected ? 5 : 2)

                    StaticPixelPetView(petType: type, frame: 0)
                        .frame(width: 60, height: 60)
                }
                .frame(width: 80, height: 80)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(isSelected ? Color.brown : Color.clear, lineWidth: 3)
                )

                Text(type.icon)
                    .font(.system(size: 20))

                Text(type.displayName)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray)
            }
        }
    }
}

// MARK: - Status Bar Component
struct StatusBar: View {
    let label: String
    let value: Double
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.2))

                    RoundedRectangle(cornerRadius: 5)
                        .fill(color)
                        .frame(width: geometry.size.width * value)
                        .animation(.easeInOut(duration: 0.3), value: value)
                }
            }
            .frame(height: 12)
        }
    }
}

// MARK: - Action Button Component
struct ActionButton: View {
    let icon: String
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                Text(label)
                    .font(.system(size: 12, weight: .medium))
            }
            .foregroundColor(.white)
            .frame(width: 70, height: 70)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.brown)
            )
            .shadow(radius: 3)
        }
    }
}

// MARK: - Dynamic Island Toggle Button
struct DynamicIslandToggleButton: View {
    let isRunning: Bool
    let petState: PetState

    var body: some View {
        Button(action: toggleActivity) {
            HStack(spacing: 8) {
                Image(systemName: isRunning ? "stop.fill" : "play.fill")
                    .font(.system(size: 16))
                Text(isRunning ? "Dynamic Island停止" : "Dynamic Islandに表示")
                    .font(.system(size: 14, weight: .medium))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(isRunning ? Color.red : Color.green)
            )
            .shadow(radius: 3)
        }
    }

    private func toggleActivity() {
        if isRunning {
            Task {
                await PetActivityManager.shared.endActivity()
            }
        } else {
            PetActivityManager.shared.startActivity(
                petType: petState.petType,
                hunger: petState.hunger,
                happiness: petState.happiness,
                energy: petState.energy
            )
        }
    }
}

#Preview {
    ContentView()
}
