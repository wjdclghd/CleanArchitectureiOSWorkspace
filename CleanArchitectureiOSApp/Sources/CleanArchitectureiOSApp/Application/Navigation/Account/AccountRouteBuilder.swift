//
//  AccountRouteBuilder.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import SwiftUI

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

    func makeRootView(
        loginState: LoginState,
        sessionController: SessionController,
        navigator: AccountNavigator
    ) -> AnyView {
        switch loginState {
        case .loggedOut:
            return loginFactory.makeLoginView(
                onLoginSuccess: {
                    sessionController.signIn()
                }
            )
        case .loggedIn:
            return myPageFactory.makeMyPageView(
                onOpenSettings: {
                    navigator.showSettings()
                },
                onLogout: {
                    sessionController.signOut()
                }
            )
        }
    }

    func build(_ route: AccountRoute, navigator: AccountNavigator) -> AnyView {
        switch route {
        case .settings:
            return placeholderFactory.makePlaceholderView(title: "설정")
        }
    }
}
