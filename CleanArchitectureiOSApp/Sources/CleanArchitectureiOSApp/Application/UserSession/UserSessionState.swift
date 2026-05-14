//
//  UserSessionState.swift
//  CleanArchitectureiOSApp
//
//  Created by Codex on 5/11/26.
//

import Foundation

enum UserSessionState: Equatable, Sendable {
    case unknown
    case restoring
    case unauthenticated
    case authenticated(UserSession)
    case expired
}

extension UserSessionState {
    var loginState: LoginState {
        switch self {
        case .authenticated:
            return .loggedIn
        case .unknown, .restoring, .unauthenticated, .expired:
            return .loggedOut
        }
    }

    var currentSession: UserSession? {
        if case let .authenticated(session) = self {
            return session
        }

        return nil
    }
}
