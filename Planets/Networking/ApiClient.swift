import Foundation

protocol ApiClientProtocol {
    func fetch<T: Decodable>(url: URLRequest) async throws -> T
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
                
                guard let httpResponse = urlResponse as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    if (urlResponse as? HTTPURLResponse)?.statusCode == 429 {
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
