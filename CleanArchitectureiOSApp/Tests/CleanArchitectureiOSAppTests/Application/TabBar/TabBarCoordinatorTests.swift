//
//  TabBarCoordinatorTests.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/14/26.
//

import XCTest
@testable import CleanArchitectureiOSApp

final class TabBarCoordinatorTests: XCTestCase {
    @MainActor
    func test_init_setsHomeAsDefaultSelectedTab() {
        let sessionController = SessionController()
        let sut = TabBarCoordinator(sessionController: sessionController)

        XCTAssertEqual(sut.selectedTab, .home)
    }

    @MainActor
    func test_select_changesSelectedTab() {
        let sessionController = SessionController()
        let sut = TabBarCoordinator(sessionController: sessionController)

        sut.select(.account)

        XCTAssertEqual(sut.selectedTab, .account)
    }

    @MainActor
    func test_loginState_reflectsSessionControllerChanges() {
        let sessionController = SessionController()
        let sut = TabBarCoordinator(sessionController: sessionController)

        sessionController.signIn()

        XCTAssertEqual(sut.loginState, .loggedIn)
    }
}
