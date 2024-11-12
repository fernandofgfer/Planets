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
            for i in 0...(map.goal.count - 1) {
                for j in 0...(map.goal[i].count - 1) {
                    let astralType = map.goal[i][j]
                    switch astralType {
                    case .polyanet:
                        try await astralDataSource.putPolyanet(row: i, column: j)
                        print("Set PolyAnet at row:\(i) columnd:\(j)")
                    case .soloon(let color):
                        try await astralDataSource.putSoloon(row: i, column: j, color: color)
                        print("Set Soloon at row:\(i) columnd:\(j)")
                    case .cometh(let direction):
                        try await astralDataSource.putCometh(row: i, column: j, direction: direction)
                        print("Set Soloon at row:\(i) columnd:\(j)")
                    case .space:
                        print("Space found at row:\(i) columnd:\(j)")
                    }
                }
            }
        } catch {
            print(error)
        }
    }
}
