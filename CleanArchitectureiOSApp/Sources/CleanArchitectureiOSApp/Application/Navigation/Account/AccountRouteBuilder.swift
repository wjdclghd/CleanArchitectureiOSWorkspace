//
//  AccountRouteBuilder.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import SwiftUI
import FeatureLogin
import FeatureMyPage

/// AccountRoute에 대응하는 화면을 생성하는 App 레이어 builder입니다.
@MainActor
struct AccountRouteBuilder {
    private let loginFactory: LoginFactory
    private let myPageFactory: MyPageFactory
    private let placeholderFactory: PlaceholderTabFactory

    init() {
        self.loginFactory = LoginFactory()
        self.myPageFactory = MyPageFactory()
        self.placeholderFactory = PlaceholderTabFactory()
    }

    /// 로그인 상태에 따라 적절한 Account root 화면을 생성합니다.
    ///
    /// - Parameters:
    ///   - loginState: 현재 로그인 상태입니다.
    ///   - sessionController: 로그인/로그아웃 액션을 수행하는 컨트롤러입니다.
    ///   - navigator: Account route navigation을 수행하는 navigator입니다.
    /// - Returns: loginState에 따라 로그인 화면 또는 마이페이지 화면입니다.
    func makeRootView(
        loginState: LoginState,
        sessionController: SessionController,
        navigator: AccountNavigator
    ) -> AnyView {
        switch loginState {
        case .loggedOut:
            return AnyView(loginFactory.makeLoginView(
                onLoginSuccess: {
                    sessionController.signIn()
                }
            ))
        case .loggedIn:
            return AnyView(myPageFactory.makeMyPageView(
                onOpenSettings: {
                    navigator.showSettings()
                },
                onLogout: {
                    sessionController.signOut()
                }
            ))
        }
    }

    /// 전달받은 route에 맞는 화면을 생성합니다.
    ///
    /// - Parameters:
    ///   - route: 생성할 화면의 route입니다.
    ///   - navigator: Account route navigation을 수행하는 navigator입니다.
    /// - Returns: route에 대응하는 화면입니다.
    func build(_ route: AccountRoute, navigator: AccountNavigator) -> AnyView {
        switch route {
        case .settings:
            return placeholderFactory.makePlaceholderView(title: "설정")
        }
    }
}
