//
//  LoginFlowUITests.swift
//  CleanArchitectureiOSAppUITests
//
//  Created by Codex on 5/11/26.
//

import XCTest

final class LoginFlowUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
    }

    override func tearDownWithError() throws {
        app.terminate()
        app = nil
    }

    func test_loginFlow_withStubLoginSuccess_showsMyPage() {
        // given
        app.launchForUITest(arguments: [
            UITestLaunchArgument.resetState,
            UITestLaunchArgument.stubLoginSuccess
        ])

        let loginPage = LoginPageObject(app: app)
        loginPage.waitForLoginRoot()

        // when
        let myPage = loginPage.login(
            email: "jch@example.com",
            password: "password123"
        )

        // then
        myPage.waitForMyPageRoot()
    }
}
