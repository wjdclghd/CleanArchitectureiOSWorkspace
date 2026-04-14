//
//  HomeRouteBuilder.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import SwiftUI

@MainActor
struct HomeRouteBuilder {
    private let homeFactory: HomeFactory
    private let searchAppStoreFactory: SearchAppStoreFactory

    init(container: DIContainer) {
        self.homeFactory = HomeFactory()
        self.searchAppStoreFactory = SearchAppStoreFactory(container: container)
    }

    func makeRootView(navigator: HomeNavigator) -> AnyView {
        homeFactory.makeHomeView(
            onSearchRequested: { keyword in
                navigator.showSearchAppStoreList(keyword: keyword)
            }
        )
    }

    func build(_ route: HomeRoute, navigator: HomeNavigator) -> AnyView {
        switch route {
        case .searchAppStoreList(let keyword):
            return searchAppStoreFactory.makeSearchListView(
                searchKeyword: keyword,
                onSelectItem: { item in
                    navigator.showSearchAppStoreDetail(trackId: item.trackId)
                }
            )
        case .searchAppStoreDetail(let trackId):
            return searchAppStoreFactory.makeSearchDetailView(trackId: trackId)
        }
    }
}
