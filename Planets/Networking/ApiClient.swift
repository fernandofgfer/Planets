import Foundation

/// Protocol defining methods for making network requests.
protocol ApiClientProtocol {

    /// Fetches and decodes data from a URL request into a specified Decodable type.
    /// - Parameter url: The URL request to fetch data from.
    /// - Returns: A decoded object of the specified type.
    /// - Throws: An error if the request fails or data cannot be decoded.
    func fetch<T: Decodable>(url: URLRequest) async throws -> T
    
    /// Fetches data from a URL request without expecting a return value.
    /// - Parameter url: The URL request to fetch data from.
    /// - Throws: An error if the request fails.
    func fetch(url: URLRequest) async throws
}

struct ApiClient: ApiClientProtocol {    
    func fetch<T>(url: URLRequest) async throws -> T where T : Decodable {
        guard let data = try await makeRequest(urlRequest: url, retry: 3) else {
            throw ApiClientError.noData
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func fetch(url: URLRequest) async throws {
        _ = try await makeRequest(urlRequest: url, retry: 3)
    }

    private func makeRequest(urlRequest: URLRequest, retry: Int) async throws -> Data? {
        for i in 0..<retry {
            do {
                let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
                
                guard let httpResponse = urlResponse as? HTTPURLResponse else {
                    throw ApiClientError.httpResponseInvalid
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    if httpResponse.statusCode == 429 {
                        usleep(3000000)
                    }
                    throw ApiClientError.httpCodeError(code: (urlResponse as? HTTPURLResponse)?.statusCode ?? 0)
                }
                
                return data
            } catch {
                if i == (retry - 1) {
                    throw error
                }
            }
        }
        return nil
    }
}
