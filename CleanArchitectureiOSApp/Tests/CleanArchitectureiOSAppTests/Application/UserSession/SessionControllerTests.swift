//
//  SessionControllerTests.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/14/26.
//

import XCTest
import AppDomain
@testable import CleanArchitectureiOSApp

final class SessionControllerTests: XCTestCase {
    @MainActor
    func test_init_setsUnauthenticatedState() {
        // given / when
        let sut = SessionController()

        // then
        XCTAssertEqual(sut.sessionState, .unauthenticated)
        XCTAssertEqual(sut.loginState, .loggedOut)
        XCTAssertFalse(sut.isLoggedIn)
    }

    @MainActor
    func test_authenticate_setsAuthenticatedState() {
        // given
        let sut = SessionController()
        let session = makeAuthSession()

        // when
        sut.authenticate(with: session)

        // then
        XCTAssertEqual(
            sut.sessionState,
            .authenticated(
                UserSession(
                    userID: 1,
                    email: "jch@example.com",
                    nickname: "jch",
                    role: "USER",
                    status: "ACTIVE"
                )
            )
        )
        XCTAssertEqual(sut.loginState, .loggedIn)
        XCTAssertTrue(sut.isLoggedIn)
    }

    @MainActor
    func test_signOut_setsLoggedOutState() {
        // given
        let sut = SessionController()
        sut.authenticate(with: makeAuthSession())

        // when
        sut.signOut()

        // then
        XCTAssertEqual(sut.sessionState, .unauthenticated)
        XCTAssertEqual(sut.loginState, .loggedOut)
        XCTAssertFalse(sut.isLoggedIn)
    }

    @MainActor
    func test_beginRestoring_setsRestoringState() {
        // given
        let sut = SessionController()

        // when
        sut.beginRestoring()

        // then
        XCTAssertEqual(sut.sessionState, .restoring)
        XCTAssertEqual(sut.loginState, .loggedOut)
    }

    @MainActor
    func test_expireSession_setsExpiredState() {
        // given
        let sut = SessionController()
        sut.authenticate(with: makeAuthSession())

        // when
        sut.expireSession()

        // then
        XCTAssertEqual(sut.sessionState, .expired)
        XCTAssertEqual(sut.loginState, .loggedOut)
    }

    @MainActor
    func test_restoreSession_setsAuthenticatedState() {
        // given
        let sut = SessionController()
        let restoredSession = UserSession(
            userID: 1,
            email: "jch@example.com",
            nickname: "jch",
            role: "USER",
            status: "ACTIVE"
        )

        // when
        sut.restoreSession(restoredSession)

        // then
        XCTAssertEqual(sut.sessionState, .authenticated(restoredSession))
        XCTAssertEqual(sut.loginState, .loggedIn)
        XCTAssertTrue(sut.isLoggedIn)
    }
}

private extension SessionControllerTests {
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
