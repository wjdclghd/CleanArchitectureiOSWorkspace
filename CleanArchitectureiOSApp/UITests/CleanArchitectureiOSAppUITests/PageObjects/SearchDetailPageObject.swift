//
//  SearchDetailPageObject.swift
//  CleanArchitectureiOSAppUITests
//
//  Created by Codex on 5/6/26.
//

import XCTest

struct SearchDetailPageObject {
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    func waitForDetail() {
        app.staticTexts[UITestAccessibilityIdentifier.SearchDetail.title]
            .waitUntilExists()
    }
}
