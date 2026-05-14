//
//  AccountLoginCoordinatorTests.swift
//  CleanArchitectureiOSAppTests
//
//  Created by Codex on 5/11/26.
//

import XCTest
import AppDomain
@testable import CleanArchitectureiOSApp

final class AccountLoginCoordinatorTests: XCTestCase {
    @MainActor
    func test_loginSucceeded_authenticatesSessionController() {
        // given
        let sessionController = SessionController()
        let sut = AccountLoginCoordinator(sessionController: sessionController)

        // when
        sut.loginSucceeded(session: makeAuthSession())

        // then
        XCTAssertEqual(sessionController.loginState, .loggedIn)
        XCTAssertEqual(sessionController.currentSession?.email, "jch@example.com")
    }
}

private extension AccountLoginCoordinatorTests {
    func makeAuthSession() -> AuthSessionEntity {
        AuthSessionEntity(
            token: AuthTokenEntity(
                accessToken: "access-token",
                refreshToken: "refresh-token",
                accessTokenExpiresAt: Date(timeIntervalSince1970: 1_800_000_000),
                refreshTokenExpiresAt: Date(timeIntervalSince1970: 1_900_000_000)
            ),
            user: AuthenticatedUserEntity(
                userId: 1,
                email: "jch@example.com",
                nickname: "jch",
                role: "USER",
                status: "ACTIVE"
            )
        )
    }
}
