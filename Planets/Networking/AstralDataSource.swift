import Foundation

protocol AstralDataSourceProtocol {
    func putPolyanet(row: Int, column: Int) async throws
    func putCometh(row: Int, column: Int, direction: String) async throws
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
                "polyanets"
            case .postCometh:
                "comeths"
            case .postSoloon:
                "soloons"
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
