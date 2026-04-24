//
//  HomeRouteBuilder.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import SwiftUI
import FeatureSearchAppStore

/*
 HomeRoute에 대응하는 화면을 생성하는 App 레벨 builder입니다.

 이 타입은 App 레이어의 DIContainer를 통해 UseCase concrete를 조립하고,
 FeatureSearchAppStore 모듈의 factory를 호출하여 실제 화면을 반환합니다.

 담당 역할
 - Home root 화면 생성
 - SearchAppStore 목록 화면 생성
 - SearchAppStore 상세 화면 생성
 - App DIContainer와 Feature factory 연결

 담당하지 않는 역할
 - Feature 내부 ViewModel 직접 구현
 - Feature 내부 View 직접 구현
 - 실제 navigation stack push / pop 수행
 */
@MainActor
struct HomeRouteBuilder {
    private let container: DIContainer
    private let homeFactory: HomeFactory

    /*
     HomeRouteBuilder를 생성합니다.

     Parameters:
     - container: App 레이어의 composition root
     */
    init(container: DIContainer) {
        self.container = container
        self.homeFactory = HomeFactory()
    }

    /*
     Home root 화면을 생성합니다.

     Parameters:
     - navigator: Home route navigation을 수행하는 navigator

     Returns:
     - Home root 화면
     */
    func makeRootView(navigator: HomeNavigator) -> AnyView {
        homeFactory.makeHomeView(
            onSearchRequested: { keyword in
                navigator.showSearchAppStoreList(keyword: keyword)
            }
        )
    }

    /*
     전달받은 route에 맞는 화면을 생성합니다.

     Parameters:
     - route: 생성할 화면의 route
     - navigator: Home route navigation을 수행하는 navigator

     Returns:
     - route에 대응하는 화면
     */
    func build(_ route: HomeRoute, navigator: HomeNavigator) -> AnyView {
        switch route {
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
                    trackId: trackId
                )
            )
        }
    }
}
