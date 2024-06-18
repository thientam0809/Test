import Foundation

class CacheWorkoutImplementation: WorkoutCacheRepository {
    private let userDefaultsKey = "cachedWorkouts"

    func saveWorkouts(_ workout: Workout?) {
        guard let workout = workout else { return }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(workout) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }

    func loadWorkouts() -> Workout? {
        if let savedData = UserDefaults.standard.object(forKey: userDefaultsKey) as? Data {
            let decoder = JSONDecoder()
            if let savedWorkout = try? decoder.decode(Workout.self, from: savedData) {
                return savedWorkout
            }
        }
        return nil
    }
}

