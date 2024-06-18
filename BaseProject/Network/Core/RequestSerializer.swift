import Foundation
import Alamofire

typealias APICompletion<T> = (APIResponse<T>) -> Void

enum APIResponse<T> {
    case success(T?)
    case failure(APIError)
}

final class NetworkingController {

    static var shared = NetworkingController()

    var defaultHTTPHeaders: HTTPHeaders {
        return ["Content-Type": "application/json"]
    }

    func performRequest<T: Decodable>(_ configuration: TargetType,
                                      for type: T.Type,
                                      completionHandler: APICompletion<T>?) -> Request? {
        var urlString: String
        if let path = configuration.path {
            urlString = configuration.baseURL / path
        } else {
            urlString = configuration.baseURL
        }
        guard Network.shared.isReachable else {
            completionHandler?(.failure(.noInternetConnection))
            return nil
        }

        var encoding: ParameterEncoding
        switch configuration.method {
        case .get, .delete:
            encoding = URLEncoding()
        default:
            encoding = JSONEncoding()
        }

        var headers: HTTPHeaders = NetworkingController.shared.defaultHTTPHeaders
        if let subHeaders = configuration.headers {
            for item in subHeaders {
                headers.add(item)
            }
        }

        let request = AF
            .request(urlString,
                     method: configuration.method,
                     parameters: configuration.parameters,
                     encoding: encoding,
                     headers: headers)
            .responseDecodable(for: T.self) { response in
                completionHandler?(response)
            }
        return request
    }
}
