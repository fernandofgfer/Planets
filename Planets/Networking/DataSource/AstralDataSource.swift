import Foundation

/// Protocol defining methods for adding various astral elements to specific positions on a map.
protocol AstralDataSourceProtocol {
    
    /// Places a Polyanet at the specified row and column on the map.
    /// - Parameters:
    ///   - row: The row position for the Polyanet.
    ///   - column: The column position for the Polyanet.
    /// - Throws: An error if the request fails.
    func putPolyanet(row: Int, column: Int) async throws
    
    /// Places a Cometh at the specified row and column, with a specified direction.
    /// - Parameters:
    ///   - row: The row position for the Cometh.
    ///   - column: The column position for the Cometh.
    ///   - direction: The direction of the Cometh.
    /// - Throws: An error if the request fails.
    func putCometh(row: Int, column: Int, direction: String) async throws
    
    /// Places a Soloon at the specified row and column, with a specified color.
    /// - Parameters:
    ///   - row: The row position for the Soloon.
    ///   - column: The column position for the Soloon.
    ///   - color: The color of the Soloon.
    /// - Throws: An error if the request fails.
    func putSoloon(row: Int, column: Int, color: String) async throws
}

struct AstralDataSource: AstralDataSourceProtocol {
    enum AstralDataSourcePaths {
        case postPolyanet
        case postCometh
        case postSoloon
        
        func getPath() -> String {
            switch self {
            case .postPolyanet:
                APIStatic.putPolyanet
            case .postCometh:
                APIStatic.putCometh
            case .postSoloon:
                APIStatic.putSoloon
            }
        }
    }
    
    private let apiClient: ApiClientProtocol
    
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    func putPolyanet(row: Int, column: Int) async throws {
        let resource = Resource(path: AstralDataSourcePaths.postPolyanet.getPath(),
                                httpMethod: .post,
                                parameters: [
                                    "candidateId": "5d36690a-c5fb-4551-9452-842898a52f46",
                                    "row": String(row),
                                    "column": String(column)
                                ])
        try await apiClient.fetch(url: URLRequest(with: resource))
    }

    func putCometh(row: Int, column: Int, direction: String) async throws {
        let resource = Resource(path: AstralDataSourcePaths.postCometh.getPath(),
                                httpMethod: .post,
                                parameters: [
                                    "candidateId": "5d36690a-c5fb-4551-9452-842898a52f46",
                                    "row": String(row),
                                    "column": String(column),
                                    "direction": direction
                                ])
        try await apiClient.fetch(url: URLRequest(with: resource))
    }

    func putSoloon(row: Int, column: Int, color: String) async throws {
        let resource = Resource(path: AstralDataSourcePaths.postSoloon.getPath(),
                                httpMethod: .post,
                                parameters: [
                                    "candidateId": "5d36690a-c5fb-4551-9452-842898a52f46",
                                    "row": String(row),
                                    "column": String(column),
                                    "color": color
                                ])
        try await apiClient.fetch(url: URLRequest(with: resource))
    }
}
