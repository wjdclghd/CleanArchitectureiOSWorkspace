//
//  TabBarCoordinatorTests.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/14/26.
//

import XCTest
import AppDomain
@testable import CleanArchitectureiOSApp

final class TabBarCoordinatorTests: XCTestCase {
    @MainActor
    func test_init_setsHomeAsDefaultSelectedTab() {
        // given / when
        let sut = TabBarCoordinator(sessionController: SessionController())

        // then
        XCTAssertEqual(sut.selectedTab, .home)
    }

    @MainActor
    func test_select_changesSelectedTab() {
        // given
        let sut = TabBarCoordinator(sessionController: SessionController())

        // when
        sut.select(.account)

        // then
        XCTAssertEqual(sut.selectedTab, .account)
    }

    @MainActor
    func test_loginState_reflectsSessionControllerChanges() {
        // given
        let sessionController = SessionController()
        let sut = TabBarCoordinator(sessionController: sessionController)

        // when
        sessionController.authenticate(with: makeAuthSession())

        // then
        XCTAssertEqual(sut.loginState, .loggedIn)
    }
}

private extension TabBarCoordinatorTests {
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
