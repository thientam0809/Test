import Alamofire

final class APIWorkout {
    
    static func getListPokemons(limit: Int, offset: Int, completionHandler: APICompletion<PokemonList>?) -> Request? {
        return NetworkingController.shared
            .performRequest(PokemonService.listPokemons(limit: limit, offset: offset),
                            for: PokemonList.self) { result in
                completionHandler?(result)
            }
    }
    
    static func getWorkouts(completionHandler: APICompletion<Workout>?) -> Request? {
        return NetworkingController.shared
            .performRequest(PokemonService.listWorkouts, for: Workout.self) { result in
                completionHandler?(result)
            }
    }
}
