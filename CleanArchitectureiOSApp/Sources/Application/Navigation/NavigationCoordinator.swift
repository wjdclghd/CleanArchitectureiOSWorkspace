//
//  NavigationCoordinator.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 12/19/25.
//

import Foundation
import SwiftUI
import Navigation

@MainActor
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
            return AnyView(
                SearchAppStoreFactory.searchAppStoreListView(
                    container: container,
                    coordinator: self,
                    searchKeyword: searchKeyword
                )
            )
        case .searchAppStoreDetailView(let trackId):
            return AnyView(
                SearchAppStoreFactory.searchAppStoreDetailView(
                    container: container,
                    coordinator: self,
                    trackId: trackId)
            )
        }
    }
}
