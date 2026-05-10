//
//  SessionControllerTests.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/14/26.
//

import XCTest
@testable import CleanArchitectureiOSApp

final class SessionControllerTests: XCTestCase {
    @MainActor
    func test_init_setsLoggedOutState() {
        let sut = SessionController()

        XCTAssertEqual(sut.loginState, .loggedOut)
        XCTAssertFalse(sut.isLoggedIn)
    }

    @MainActor
    func test_signIn_setsLoggedInState() {
        let sut = SessionController()

        sut.signIn()

        XCTAssertEqual(sut.loginState, .loggedIn)
        XCTAssertTrue(sut.isLoggedIn)
    }

    @MainActor
    func test_signOut_setsLoggedOutState() {
        let sut = SessionController()
        sut.signIn()

        sut.signOut()

        XCTAssertEqual(sut.loginState, .loggedOut)
        XCTAssertFalse(sut.isLoggedIn)
    }
}
