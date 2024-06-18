import Foundation
import Alamofire

enum PokemonService {
    case listPokemons(limit: Int, offset: Int)
    case listWorkouts
}

extension PokemonService: TargetType {

    var baseURL: String {
        return "https://demo6732818.mockable.io"
    }

    var version: String {
        guard let version = AppConfiguration.infoForKey(.apiVersion) else {
            fatalError("Missing version api")
        }
        return version
    }

    var path: String? {
        switch self {
        case .listPokemons:
            return "pokemon"
        case .listWorkouts:
            return "workouts"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .listPokemons:
            return .get
        case .listWorkouts:
            return .get
        }
    }

    var parameters: Parameters? {
        switch self {
        case .listPokemons(let limit, let offset):
            return ["limit": limit, "offset": offset]
        case .listWorkouts:
            return nil
        }
    }
}
