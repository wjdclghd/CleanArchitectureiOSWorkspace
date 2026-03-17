//
//  SearchAppStoreList.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/17/26.
//

import Foundation
import SwiftUI

struct SearchAppStoreListView: View {
    @StateObject private var viewModel: SearchAppStoreListViewModel
    
    init(viewModel: SearchAppStoreListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("SearchAppStoreList")
                .font(.largeTitle)
            
            Text("searchKeyword: \(viewModel.searchKeyword)")
                .font(.headline)
        }
        .padding()
        .navigationTitle("SearchAppStore")
    }
}
