import SwiftUI

struct ContentView: View {
    @StateObject private var petState = PetState()

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

                        // Pet Name
                        Text(petState.name)
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
                .frame(width: 200, height: 200)

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

                Spacer()
            }
            .padding(.top, 50)
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

#Preview {
    ContentView()
}
