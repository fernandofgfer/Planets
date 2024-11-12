import Foundation

protocol MainViewModelProtocol {
    func doAPolyanetCross() async
}

struct MainViewModel: MainViewModelProtocol {
    
    private let galaxyMapDataSource: GalaxyMapDataSourceProtocol
    private let astralDataSource: AstralDataSourceProtocol
    
    init(galaxyMapDataSource: GalaxyMapDataSourceProtocol, astralDataSource: AstralDataSourceProtocol) {
        self.galaxyMapDataSource = galaxyMapDataSource
        self.astralDataSource = astralDataSource
    }
    
    func doAPolyanetCross() async {
        do {
            let map = try await galaxyMapDataSource.fetchGoalMap()
            
            try await withThrowingTaskGroup(of: Void.self) { group in
                for i in 0...(map.goal.count - 1) {
                    for j in 0...(map.goal[i].count - 1) {
                        if map.goal[i][j] == .Polyanet {
                            group.addTask {
                                try await astralDataSource.putPolyanet(row: i, column: j)
                                print("Set PolyAnet row:\(i) columnd:\(j)")
                            }
                        }
                    }
                }
                try await group.waitForAll()
            }
        } catch {
            print(error)
        }
        
//        let urlRequest = URLRequest(crossmintPath: "map/5d36690a-c5fb-4551-9452-842898a52f46/goal")!
//        do {
//            let map: Map? = try await apiClient.fetch(url: urlRequest)
//            if let map {
//                for i in 0...(map.goal.count - 1) {
//                    for j in 0...(map.goal[i].count - 1) {
//                        if map.goal[i][j] == .Polyanet {
//                            let urlRequest = URLRequest(crossmintPath: "polyanets", parameters: Position(row: i, column: j), httpMethod: .post)
//                            try await apiClient.fetch(url: urlRequest!)
//                        }
//                    }
//                }
//            }
//        } catch {
//            print(error)
//        }
        
    }
}
