import Foundation

class HomeRepositoryImplementation: HomeRepository {
    private let cacheRepository: WorkoutCacheRepository
    
    init(cacheRepository: WorkoutCacheRepository) {
        self.cacheRepository = cacheRepository
    }
    
    func getWorkouts(completion: @escaping (Result<Workout?, Error>) -> Void) {
        let _ = APIWorkout.getWorkouts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let lists):
                self.cacheRepository.saveWorkouts(lists)
                completion(.success(lists))
            case .failure(let error):
                if let cachedWorkouts = self.cacheRepository.loadWorkouts() {
                    completion(.success(cachedWorkouts))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
}


class HomeRepositoryImplementationMock: HomeRepository {
    func getWorkouts(completion: @escaping (Result<Workout?, any Error>) -> Void) {
        if let path = Bundle.main.path(forResource: "workouts", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                let lists = try decoder.decode(Workout.self, from: data)
                completion(.success(lists))
            } catch {
                completion(.failure(error))
            }
        } else {
            let error = NSError(domain: "HomeRepositoryImplementationMock", code: 1, userInfo: [NSLocalizedDescriptionKey: "File not found"])
            completion(.failure(error))
        }
    }
}

class HomeRepositoryImplementationMockWithFailure: HomeRepository {
    func getWorkouts(completion: @escaping (Result<Workout?, any Error>) -> Void) {
        if let path = Bundle.main.path(forResource: "workoutsFailure", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                let lists = try decoder.decode(Workout.self, from: data)
                completion(.success(lists))
            } catch {
                completion(.failure(error))
            }
        } else {
            let error = NSError(domain: "HomeRepositoryImplementationMock", code: 1, userInfo: [NSLocalizedDescriptionKey: "File not found"])
            completion(.failure(error))
        }
    }
}

