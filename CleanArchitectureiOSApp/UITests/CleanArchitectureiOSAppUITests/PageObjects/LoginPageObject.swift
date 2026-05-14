//
//  LoginPageObject.swift
//  CleanArchitectureiOSAppUITests
//
//  Created by Codex on 5/11/26.
//

import XCTest

struct LoginPageObject {
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    func waitForLoginRoot() {
        app.descendants(matching: .any)[UITestAccessibilityIdentifier.Account.loginRoot]
            .waitUntilExists(timeout: 8)
    }

    func login(email: String, password: String) -> MyPageObject {
        app.descendants(matching: .any)[UITestAccessibilityIdentifier.Login.emailTextField]
            .waitUntilExists(timeout: 8)
            .tap()
        app.descendants(matching: .any)[UITestAccessibilityIdentifier.Login.emailTextField]
            .typeText(email)

        app.descendants(matching: .any)[UITestAccessibilityIdentifier.Login.passwordSecureField]
            .waitUntilExists(timeout: 8)
            .tap()
        app.descendants(matching: .any)[UITestAccessibilityIdentifier.Login.passwordSecureField]
            .typeText(password)

        app.descendants(matching: .any)[UITestAccessibilityIdentifier.Login.submitButton]
            .waitUntilExists(timeout: 8)
            .tap()

        return MyPageObject(app: app)
    }
}
