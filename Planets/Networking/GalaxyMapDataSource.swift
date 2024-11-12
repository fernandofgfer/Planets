import Foundation

protocol GalaxyMapDataSourceProtocol {
    func fetchGoalMap() async throws -> Map
}

struct GalaxyMapDataSource: GalaxyMapDataSourceProtocol {
    
    enum GalaxyMapDataSourcePaths {
        case getGoal
        
        func getPath() -> String {
            switch self {
            case .getGoal:
                "map/5d36690a-c5fb-4551-9452-842898a52f46/goal"
            }
        }
    }
    
    private let apiClient: ApiClientProtocol
    
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchGoalMap() async throws -> Map {
        let resource = Resource(path: GalaxyMapDataSourcePaths.getGoal.getPath())
        return try await apiClient.fetch(url: URLRequest(with: resource))
    }
}
