extension App {

    struct String { }
}

extension App.String {

    struct Common { }

    struct Example { }

    struct Identifier { }

    struct APIError { }
}

// MARK: - Common
extension App.String.Common {
    static let okButton: String = "OK"
    static let cancelButton: String = "Cancel"
}

extension App.String.Example {
    static let title: String = "Pokemon List"
}

// MARK: - Identifier
extension App.String.Identifier {
    static let exampleCell: String = "ExampleCell"
}

// MARK: - APIError
extension App.String.APIError {
    static let unknownError: String = "Unknown Error"
    static let noInternetConnection: String = "No Internet Connection"
    static let requestTimeout: String = "Request Timeout"
    static let forceUpdate: String = "Force Update"
}
