import ActivityKit
import SwiftUI

// MARK: - Live Activity Attributes
struct PetActivityAttributes: ActivityAttributes {
    // Static data that doesn't change during the activity
    public struct ContentState: Codable, Hashable {
        var petType: String
        var frame: Int
        var hunger: Double
        var happiness: Double
        var energy: Double
    }

    // Fixed data
    var petName: String
}

// MARK: - Activity Manager
@MainActor
class PetActivityManager: ObservableObject {
    static let shared = PetActivityManager()

    @Published var currentActivity: Activity<PetActivityAttributes>?
    @Published var isActivityRunning = false

    private var animationTimer: Timer?
    private var currentFrame = 0

    private init() {}

    // MARK: - Start Live Activity
    func startActivity(petType: PetType, hunger: Double, happiness: Double, energy: Double) {
        // Check if Live Activities are supported
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            print("Live Activities are not enabled")
            return
        }

        // End any existing activity
        Task {
            await endActivity()
        }

        let attributes = PetActivityAttributes(petName: petType.displayName)
        let initialState = PetActivityAttributes.ContentState(
            petType: petType.rawValue,
            frame: 0,
            hunger: hunger,
            happiness: happiness,
            energy: energy
        )

        let content = ActivityContent(state: initialState, staleDate: nil)

        do {
            currentActivity = try Activity.request(
                attributes: attributes,
                content: content,
                pushType: nil
            )
            isActivityRunning = true
            startAnimationTimer(petType: petType, hunger: hunger, happiness: happiness, energy: energy)
            print("Live Activity started successfully")
        } catch {
            print("Failed to start Live Activity: \(error)")
        }
    }

    // MARK: - Animation Timer
    private func startAnimationTimer(petType: PetType, hunger: Double, happiness: Double, energy: Double) {
        animationTimer?.invalidate()
        currentFrame = 0

        animationTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.currentFrame = (self.currentFrame + 1) % 4

            Task { @MainActor in
                await self.updateActivity(
                    petType: petType,
                    frame: self.currentFrame,
                    hunger: hunger,
                    happiness: happiness,
                    energy: energy
                )
            }
        }
    }

    // MARK: - Update Activity
    func updateActivity(petType: PetType, frame: Int, hunger: Double, happiness: Double, energy: Double) async {
        guard let activity = currentActivity else { return }

        let updatedState = PetActivityAttributes.ContentState(
            petType: petType.rawValue,
            frame: frame,
            hunger: hunger,
            happiness: happiness,
            energy: energy
        )

        let content = ActivityContent(state: updatedState, staleDate: nil)
        await activity.update(content)
    }

    // MARK: - End Activity
    func endActivity() async {
        animationTimer?.invalidate()
        animationTimer = nil

        guard let activity = currentActivity else { return }

        let finalState = PetActivityAttributes.ContentState(
            petType: "dog",
            frame: 0,
            hunger: 0.5,
            happiness: 0.5,
            energy: 0.5
        )

        let content = ActivityContent(state: finalState, staleDate: nil)
        await activity.end(content, dismissalPolicy: .immediate)

        currentActivity = nil
        isActivityRunning = false
        print("Live Activity ended")
    }
}
