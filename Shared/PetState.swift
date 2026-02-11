import SwiftUI
import Combine

// MARK: - Pet State (Shared between App and Widget)
class PetState: ObservableObject {
    @Published var name: String = "Pixel"
    @Published var hunger: Double = 0.7
    @Published var happiness: Double = 0.8
    @Published var energy: Double = 0.6
    @Published var currentFrame: Int = 0
    @Published var isAnimating: Bool = true

    private var timer: Timer?
    private let frameCount = 4

    init() {
        startAnimation()
        startDecay()
    }

    // MARK: - Animation
    func startAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { [weak self] _ in
            guard let self = self, self.isAnimating else { return }
            self.currentFrame = (self.currentFrame + 1) % self.frameCount
        }
    }

    // MARK: - Stats Decay Over Time
    func startDecay() {
        Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.hunger = max(0, self.hunger - 0.05)
            self.happiness = max(0, self.happiness - 0.03)
            self.energy = max(0, self.energy - 0.02)
        }
    }

    // MARK: - Actions
    func feed() {
        withAnimation {
            hunger = min(1.0, hunger + 0.3)
            happiness = min(1.0, happiness + 0.1)
        }
    }

    func pet() {
        withAnimation {
            happiness = min(1.0, happiness + 0.3)
            energy = max(0, energy - 0.1)
        }
    }

    func sleep() {
        withAnimation {
            energy = min(1.0, energy + 0.4)
            hunger = max(0, hunger - 0.1)
        }
    }
}

// MARK: - App Group for Widget Communication
struct PetDataManager {
    static let appGroupID = "group.com.pixelpet.shared"

    static func savePetState(_ state: PetState) {
        guard let userDefaults = UserDefaults(suiteName: appGroupID) else { return }
        userDefaults.set(state.name, forKey: "petName")
        userDefaults.set(state.hunger, forKey: "hunger")
        userDefaults.set(state.happiness, forKey: "happiness")
        userDefaults.set(state.energy, forKey: "energy")
    }

    static func loadPetState() -> (name: String, hunger: Double, happiness: Double, energy: Double) {
        guard let userDefaults = UserDefaults(suiteName: appGroupID) else {
            return ("Pixel", 0.7, 0.8, 0.6)
        }
        return (
            userDefaults.string(forKey: "petName") ?? "Pixel",
            userDefaults.double(forKey: "hunger"),
            userDefaults.double(forKey: "happiness"),
            userDefaults.double(forKey: "energy")
        )
    }
}
