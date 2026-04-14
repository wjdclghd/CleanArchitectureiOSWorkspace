//
//  UserSessionStoreTests.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/14/26.
//

import XCTest
@testable import CleanArchitectureiOSApp

@MainActor
final class SessionControllerTests: XCTestCase {
    func test_init_setsLoggedOutState() {
        let sut = SessionController()

        XCTAssertEqual(sut.loginState, .loggedOut)
        XCTAssertFalse(sut.isLoggedIn)
    }

    func test_signIn_setsLoggedInState() {
        let sut = SessionController()

        sut.signIn()

        XCTAssertEqual(sut.loginState, .loggedIn)
        XCTAssertTrue(sut.isLoggedIn)
    }

    func test_signOut_setsLoggedOutState() {
        let sut = SessionController()
        sut.signIn()

        sut.signOut()

        XCTAssertEqual(sut.loginState, .loggedOut)
        XCTAssertFalse(sut.isLoggedIn)
    }
}
