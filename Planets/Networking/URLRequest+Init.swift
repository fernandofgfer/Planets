import Foundation

/// Extension of `URLRequest` to initialize a request with a `Resource`.
extension URLRequest {
    
    /// Initializes a `URLRequest` with the given `Resource`.
    /// - Parameter resource: The `Resource` containing path, HTTP method, and parameters.
    /// - Throws: An `ApiClientError.urlError` if the URL is invalid.
    init(with resource: Resource) throws {
        // Construct the full URL from the base and resource path
        guard let url = URL(string: "https://challenge.crossmint.io/api/\(resource.path)") else {
            throw ApiClientError.urlError
        }
        self.init(url: url)
        
        // Configure request for POST method
        if resource.httpMethod == .post {
            self.httpBody = try? JSONSerialization.data(withJSONObject: resource.parameters)
            self.httpMethod = resource.httpMethod.rawValue
            self.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}
enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

