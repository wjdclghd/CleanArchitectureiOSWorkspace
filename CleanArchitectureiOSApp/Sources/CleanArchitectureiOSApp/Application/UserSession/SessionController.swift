//
//  SessionController.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import Foundation
import AppDomain

@MainActor
final class SessionController: ObservableObject {
    @Published private(set) var sessionState: UserSessionState = .unauthenticated

    var loginState: LoginState {
        sessionState.loginState
    }

    var currentSession: UserSession? {
        sessionState.currentSession
    }

    var isLoggedIn: Bool {
        loginState == .loggedIn
    }

    func beginRestoring() {
        sessionState = .restoring
    }

    func authenticate(with session: AuthSessionEntity) {
        sessionState = .authenticated(
            UserSession(authenticatedUser: session.user)
        )
    }

    func restoreSession(_ session: UserSession) {
        sessionState = .authenticated(session)
    }

    func restoreSession(_ user: AuthenticatedUserEntity) {
        restoreSession(UserSession(authenticatedUser: user))
    }

    func signOut() {
        sessionState = .unauthenticated
    }

    func expireSession() {
        sessionState = .expired
    }
}
