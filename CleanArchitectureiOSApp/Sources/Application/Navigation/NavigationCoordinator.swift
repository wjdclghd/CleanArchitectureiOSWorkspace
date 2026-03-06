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
    private let navigator: Navigator<AppRoute>

    init(container: DIContainer, navigator: Navigator<AppRoute>) {
        self.container = container
        self.navigator = navigator
    }

    func push(_ route: AppRoute) {
        navigator.push(route)
    }
    
    func pop() {
        navigator.pop()
    }
    
    func popToRoot() {
        navigator.popToRoot()
    }
    
    func present(_ route: AppRoute) {
        navigator.present(route)
    }
    
    func dismiss() {
        navigator.dismiss()
    }

    func pushFromAnywhere(_ route: AppRoute) {
        navigator.push(route)
    }

//    func rootView() -> AnyView {
//        AnyView(AppViewFactory.mainMenuViewFactory(coordinator: self))
//    }
    
//    func build(route: AppRoute) -> AnyView {
//        switch route {
//        case .main:
//            return rootView()
//        case .searchList:
//            return AnyView(AppViewFactory.searchListViewFactory(container: container, coordinator: self))
//        case .searchDetailList(let searchKeyword):
//            return AnyView(AppViewFactory.searchDetailListViewFactory(container: container, coordinator: self, searchKeyword: searchKeyword))
//        case .searchDetail(let entity):
//            return AnyView(AppViewFactory.searchDetailViewFactory(coordinator: self, entity: entity))
//        case .chatGPTSearch:
//            return AnyView(AppViewFactory.chatGPTSearchViewFactory(container: container, coordinator: self))
//        case .userRecommendation:
//            return AnyView(AppViewFactory.userRecommendationViewFactory(container: container, coordinator: self))
//        }
//    }
}
