//
//  UserSession.swift
//  CleanArchitectureiOSApp
//
//  Created by Codex on 5/11/26.
//

import Foundation
import AppDomain

struct UserSession: Equatable, Sendable {
    let userID: Int64
    let email: String
    let nickname: String
    let role: String
    let status: String

    init(
        userID: Int64,
        email: String,
        nickname: String,
        role: String,
        status: String
    ) {
        self.userID = userID
        self.email = email
        self.nickname = nickname
        self.role = role
        self.status = status
    }

    init(authenticatedUser: AuthenticatedUserEntity) {
        self.init(
            userID: Int64(authenticatedUser.userId),
            email: authenticatedUser.email,
            nickname: authenticatedUser.nickname,
            role: authenticatedUser.role,
            status: authenticatedUser.status
        )
    }
}
