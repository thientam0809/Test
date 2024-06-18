import Alamofire

typealias Network = NetworkReachabilityManager

// MARK: - Network
extension Network {

    static let shared: Network = {
        guard let manager = Network() else {
            fatalError(App.String.APIError.unknownError)
        }
        return manager
    }()
}

enum APIError: Error, Decodable {

    case emptyOrInvalidResponse
    case cancelRequest
    case badRequest
    case noInternetConnection
    case requestTimeout
    case forceUpdate
    case unknown

    init(from statusCode: Int) {
        switch statusCode {
        case 400:
            self = .cancelRequest
        case 404:
            self = .badRequest
        case -1_001:
            self = .requestTimeout
        case 426:
            self = .forceUpdate
        default:
            self = .unknown
        }
    }

    var errorDescription: String {
        switch self {
        case .noInternetConnection:
            return App.String.APIError.noInternetConnection
        case .requestTimeout:
            return App.String.APIError.requestTimeout
        case .forceUpdate:
            return App.String.APIError.forceUpdate
        case .unknown, .emptyOrInvalidResponse, .cancelRequest, .badRequest:
            return App.String.APIError.unknownError
        }
    }

    var statusCode: Int {
        switch self {
        case .cancelRequest, .emptyOrInvalidResponse, .unknown:
            return 400
        case .badRequest:
            return 404
        case .noInternetConnection:
            return 599
        case .requestTimeout:
            return -1_001
        case .forceUpdate:
            return 426
        }
    }
}

extension Error {

    func show() {
        let `self` = self as NSError
        self.show()
    }

    public var code: Int {
        let `self` = self as NSError
        return self.code
    }
}

extension NSError {
    func show() { }
}
