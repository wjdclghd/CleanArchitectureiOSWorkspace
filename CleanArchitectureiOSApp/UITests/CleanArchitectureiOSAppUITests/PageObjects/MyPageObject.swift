//
//  MyPageObject.swift
//  CleanArchitectureiOSAppUITests
//
//  Created by Codex on 5/11/26.
//

import XCTest

struct MyPageObject {
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    func waitForMyPageRoot() {
        app.descendants(matching: .any)[UITestAccessibilityIdentifier.Account.myPageRoot]
            .waitUntilExists(timeout: 8)
    }
}
