//
//  SearchAppStoreFactory.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/17/26.
//

import Foundation
import SwiftUI

enum SearchAppStoreFactory {
    static func searchAppStoreListView(searchKeyword: String, coordinator: NavigationCoordinator) -> some View {
        let viewModel = SearchAppStoreListViewModel(searchKeyword: searchKeyword)
        
        return SearchAppStoreListView(viewModel: viewModel)
    }
}
