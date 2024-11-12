import Foundation

extension URLRequest {    
    init(with resource: Resource) throws {
        guard let url = URL(string: "https://challenge.crossmint.io/api/\(resource.path)") else {
            throw ApiClientError.urlError
        }
        self.init(url: url)
        
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

