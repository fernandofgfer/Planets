import SwiftUI

struct MainAssembler {
    @ViewBuilder func make() -> some View {
        let apiClient = ApiClient()
        let astralDataSource = AstralDataSource(apiClient: apiClient)
        let galaxyMapDataSource = GalaxyMapDataSource(apiClient: apiClient)
        
        let viewModel = MainViewModel(galaxyMapDataSource: galaxyMapDataSource,
                                      astralDataSource: astralDataSource)
        
        MainView(viewModel: viewModel)
    }
}
