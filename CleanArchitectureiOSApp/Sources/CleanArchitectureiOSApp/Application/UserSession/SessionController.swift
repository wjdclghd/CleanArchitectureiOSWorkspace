//
//  SessionController.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import Foundation

@MainActor
final class SessionController: ObservableObject {
    @Published private(set) var loginState: LoginState = .loggedOut

    var isLoggedIn: Bool {
        loginState == .loggedIn
    }

    func signIn() {
        loginState = .loggedIn
    }

    func signOut() {
        loginState = .loggedOut
    }
}
