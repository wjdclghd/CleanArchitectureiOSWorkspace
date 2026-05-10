//
//  HomeNavigator.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import Foundation
import Navigation
import FeatureHome
import FeatureSearch
import FeatureSearchAppStore

/// Home 화면 흐름에서 HomeCoordinatorProtocol, SearchCoordinatorProtocol, SearchAppStoreCoordinatorProtocol을 구현하는 App 레이어 navigator입니다.
@MainActor
final class HomeNavigator: HomeCoordinatorProtocol, SearchCoordinatorProtocol, SearchAppStoreCoordinatorProtocol {
    private let navigator: Navigator<HomeRoute>

    init(navigator: Navigator<HomeRoute>) {
        self.navigator = navigator
    }

    func showSearch() {
        navigator.push(.search)
    }

    /// 확정된 검색어로 AppStore 검색 목록 화면으로 이동합니다.
    ///
    /// - Parameter keyword: 검색 목록 화면 진입에 사용할 검색어입니다.
    func showSearchAppStoreList(keyword: String) {
        navigator.push(.searchAppStoreList(keyword: keyword))
    }

    /// AppStore 앱 상세 화면으로 이동합니다.
    ///
    /// - Parameter trackId: 상세 조회에 사용할 앱 식별자입니다.
    func showSearchAppStoreDetail(trackId: Int) {
        navigator.push(.searchAppStoreDetail(trackId: trackId))
    }

    func pop() {
        navigator.pop()
    }

    func popToRoot() {
        navigator.popToRoot()
    }

    func dismiss() {
        navigator.dismiss()
    }
}
