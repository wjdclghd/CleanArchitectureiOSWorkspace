//
//  NavigationCoordinator.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 12/19/25.
//

import Foundation
import SwiftUI
import Navigation

final class NavigationCoordinator {
    private let container: DIContainer
    private let navigator: Navigator<NavigationRoute>

    init(container: DIContainer, navigator: Navigator<NavigationRoute>) {
        self.container = container
        self.navigator = navigator
    }

    func push(_ route: NavigationRoute) {
        navigator.push(route)
    }
    
    func pop() {
        navigator.pop()
    }
    
    func popToRoot() {
        navigator.popToRoot()
    }
    
    func present(_ route: NavigationRoute) {
        navigator.present(route)
    }
    
    func dismiss() {
        navigator.dismiss()
    }
    
    func build(route: NavigationRoute) -> AnyView {
        switch route {
        case .searchAppStoreListView(let searchKeyword):
            return AnyView(SearchAppStoreFactory.searchAppStoreListView(searchKeyword: searchKeyword, coordinator: self))
//        case .searchDetailList(let searchKeyword):
//            return AnyView(AppViewFactory.searchDetailListViewFactory(container: container, coordinator: self, searchKeyword: searchKeyword))
//        case .searchDetail(let entity):
//            return AnyView(AppViewFactory.searchDetailViewFactory(coordinator: self, entity: entity))
//        case .chatGPTSearch:
//            return AnyView(AppViewFactory.chatGPTSearchViewFactory(container: container, coordinator: self))
//        case .userRecommendation:
//            return AnyView(AppViewFactory.userRecommendationViewFactory(container: container, coordinator: self))
        }
    }
}
