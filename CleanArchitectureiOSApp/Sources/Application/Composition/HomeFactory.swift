//
//  HomeFactory.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 12/19/25.
//

import Foundation
import SwiftUI
//import CoreDatabase
//import CoreNetwork
//import AppStoreAPIModule
//import ChatGPTAPIModule
//import UserRecommendationModule

enum HomeFactory {
//    static func homeView(coordinator: NavigationCoordinator) -> some View {
//        HomeView(coordinator: coordinator)
//    }
    
    static func homeView(coordinator: NavigationCoordinator, onLogout: @escaping () -> Void) -> some View {
        HomeView(coordinator: coordinator, onLogout: onLogout)
    }
    
//    static func mainMenuViewFactory(coordinator: NavigationCoordinator) -> some View {
//        MainMenuView(coordinator: coordinator)
//    }

//    static func searchListViewFactory(container: DIContainer, coordinator: NavigationCoordinator) -> some View {
//        let searchListViewModel = SearchListViewModel(useCase: container.searchListUseCase)
//        
//        return SearchListView(viewModel: searchListViewModel, onPush: { searchKeyword in coordinator.push(route: .searchDetailList(searchKeyword: searchKeyword))}
//        )
//    }
//
//    static func searchDetailListViewFactory(container: DIContainer, coordinator: NavigationCoordinator, searchKeyword: String) -> some View {
//        let searchDetailListUseCase = container.searchDetailListUseCase(searchKeyword)
//        let searchDetailListViewModel = SearchDetailListViewModel(useCase: searchDetailListUseCase, searchKeyword: searchKeyword)
//        
//        return SearchDetailListView(viewModel: searchDetailListViewModel, onPush: { entity in coordinator.push(route: .searchDetail(entity: entity))}
//        )
//    }
//
//    static func searchDetailViewFactory(coordinator: NavigationCoordinator, entity: SearchDetailEntity) -> some View {
//        let searchDetailViewModel = SearchDetailViewModel(entity: entity)
//        
//        return SearchDetailView(viewModel: searchDetailViewModel, onPop: { coordinator.pop() })
//    }
//    
//    static func chatGPTSearchViewFactory(container: DIContainer, coordinator: NavigationCoordinator) -> some View {
//        let chatGPTSearchViewModel = ChatGPTSearchViewModel(useCase: container.chatGPTSearchUseCase)
//        
//        return ChatGPTSearchView(viewModel: chatGPTSearchViewModel, onPush: { coordinator.push(route: .chatGPTSearch)})
//    }
//    
//    static func userRecommendationViewFactory(container: DIContainer, coordinator: NavigationCoordinator) -> some View {
//        let userRecommendationViewModel = UserRecommendationViewModel(useCase: container.userRecommendationUseCase)
//        
//        return UserRecommendationView(viewModel: userRecommendationViewModel, onPush: { coordinator.push(route: .userRecommendation) })
//    }
}
