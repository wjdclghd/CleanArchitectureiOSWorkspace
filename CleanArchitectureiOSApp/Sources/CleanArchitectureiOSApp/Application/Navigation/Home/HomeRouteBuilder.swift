//
//  HomeRouteBuilder.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import SwiftUI
import FeatureHome
import FeatureSearch
import FeatureSearchAppStore

/// HomeRoute에 대응하는 화면을 생성하는 App 레이어 builder입니다.
///
/// DIContainer를 통해 UseCase를 조립하고 Feature factory를 호출하여 화면을 반환합니다.
@MainActor
struct HomeRouteBuilder {
    private let container: DIContainer

    init(container: DIContainer) {
        self.container = container
    }

    /// Home root 화면을 생성합니다.
    ///
    /// - Parameter navigator: Home route navigation을 수행하는 navigator입니다.
    /// - Returns: Home root 화면입니다.
    func makeRootView(navigator: HomeNavigator) -> AnyView {
        AnyView(HomeFactory.makeHomeView(coordinator: navigator))
    }

    /// 전달받은 route에 맞는 화면을 생성합니다.
    ///
    /// - Parameters:
    ///   - route: 생성할 화면의 route입니다.
    ///   - navigator: Home route navigation을 수행하는 navigator입니다.
    /// - Returns: route에 대응하는 화면입니다.
    func build(_ route: HomeRoute, navigator: HomeNavigator) -> AnyView {
        switch route {
        case .search:
            let historyUseCase = container.makeSearchHistoryUseCase()
            let candidateUseCase = container.makeSearchCandidateUseCase()

            return AnyView(
                SearchFactory.makeSearchView(
                    historyUseCase: historyUseCase,
                    candidateUseCase: candidateUseCase,
                    coordinator: navigator
                )
            )

        case .searchAppStoreList(let keyword):
            let useCase = container.makeSearchAppStoreListUseCase()

            return AnyView(
                SearchAppStoreFactory.makeSearchAppStoreListView(
                    useCase: useCase,
                    coordinator: navigator,
                    searchKeyword: keyword
                )
            )

        case .searchAppStoreDetail(let trackId):
            let useCase = container.makeSearchAppStoreDetailUseCase()

            return AnyView(
                SearchAppStoreFactory.makeSearchAppStoreDetailView(
                    useCase: useCase,
                    coordinator: navigator,
                    trackId: trackId
                )
            )
        }
    }
}
