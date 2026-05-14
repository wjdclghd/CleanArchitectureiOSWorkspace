//
//  AccountNavigator.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import Foundation
import Navigation
import FeatureMyPage

/// Account 화면 흐름에서 사용하는 App 레이어 navigator입니다.
@MainActor
final class AccountNavigator: MyPageCoordinatorProtocol {
    private let navigator: Navigator<AccountRoute>

    init(navigator: Navigator<AccountRoute>) {
        self.navigator = navigator
    }

    func showSettings() {
        navigator.push(.settings)
    }

    func pop() {
        navigator.pop()
    }

    func popToRoot() {
        navigator.popToRoot()
    }

    // MARK: - MyPageCoordinatorProtocol

    func openSettings() {
        showSettings()
    }
}
