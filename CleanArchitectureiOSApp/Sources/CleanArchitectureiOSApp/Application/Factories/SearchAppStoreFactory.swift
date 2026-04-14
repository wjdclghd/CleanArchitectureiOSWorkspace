//
//  SearchAppStoreFactory.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import SwiftUI

@MainActor
struct SearchAppStoreFactory {
    private let container: DIContainer

    init(container: DIContainer) {
        self.container = container
    }

    func makeSearchListView(
        searchKeyword: String,
        onSelectItem: @escaping (SearchAppStoreListEntity) -> Void
    ) -> AnyView {
        let viewModel = SearchAppStoreListViewModel(
            useCase: container.searchAppStoreListUseCase,
            searchKeyword: searchKeyword
        )

        return AnyView(
            SearchAppStoreListView(
                viewModel: viewModel,
                onSelectItem: onSelectItem
            )
        )
    }

    func makeSearchDetailView(trackId: Int) -> AnyView {
        let viewModel = SearchAppStoreDetailViewModel(
            useCase: container.searchAppStoreDetailUseCase,
            trackId: trackId
        )

        return AnyView(
            SearchAppStoreDetailView(
                viewModel: viewModel
            )
        )
    }
}
