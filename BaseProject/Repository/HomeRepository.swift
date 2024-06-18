import Foundation

protocol HomeRepository {
    func getWorkouts(completion: @escaping (Result<Workout?, Error>) -> Void)
}

protocol WorkoutCacheRepository {
    func saveWorkouts(_ workout: Workout?)
    func loadWorkouts() -> Workout?
}
