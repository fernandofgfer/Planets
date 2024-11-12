//
//  ContentView.swift
//  Planets
//
//  Created by Fernando Garcia Fernandez on 11/11/24.
//

import SwiftUI

struct MainView: View {
    
    private let viewModel: MainViewModelProtocol
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Button("First Stage") {
                Task {
                    await viewModel.doAPolyanetCross()
                }
            }
        }
        .padding()
    }
}

//#Preview {
//    MainView(viewModel: MainViewModel())
//}