import Foundation

protocol AstralDataSourceProtocol {
    func putPolyanet(row: Int, column: Int) async throws
}

struct AstralDataSource: AstralDataSourceProtocol {
    enum AstralDataSourcePaths {
        case postPolyanet
        
        func getPath() -> String {
            switch self {
            case .postPolyanet:
                "polyanets"
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
}
