//
//  SearchAppStoreFactory.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/17/26.
//

import Foundation
import SwiftUI

@MainActor
enum SearchAppStoreFactory {
    static func searchAppStoreListView(
        container: DIContainer,
        coordinator: NavigationCoordinator,
        searchKeyword: String
    ) -> some View {
        let viewModel = SearchAppStoreListViewModel(
            useCase: container.searchAppStoreListUseCase,
            searchKeyword: searchKeyword
        )
        
        return SearchAppStoreListView(
            viewModel: viewModel,
            onSelectItem: { item in
                coordinator.push(.searchAppStoreDetailView(trackId: item.trackId))
            }
        )
    }
    
    static func searchAppStoreDetailView(
        container: DIContainer,
        coordinator: NavigationCoordinator,
        trackId: Int
    ) -> some View {
        let viewModel = SearchAppStoreDetailViewModel(
            useCase: container.searchAppStoreDetailUseCase,
            trackId: trackId
        )
        
        return SearchAppStoreDetailView(
            viewModel: viewModel,
            onBack: {
                coordinator.pop()
            }
        )
    }
}
