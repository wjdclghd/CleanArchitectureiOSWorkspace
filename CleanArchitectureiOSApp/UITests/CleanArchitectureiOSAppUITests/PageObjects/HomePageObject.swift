//
//  HomePageObject.swift
//  CleanArchitectureiOSAppUITests
//
//  Created by Codex on 5/6/26.
//

import XCTest

struct HomePageObject {
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    func waitForSearchEntry() {
        app.buttons[UITestAccessibilityIdentifier.Home.searchEntry]
            .waitUntilExists(timeout: 8)
    }

    func tapSearchEntry() -> SearchPageObject {
        app.buttons[UITestAccessibilityIdentifier.Home.searchEntry]
            .waitUntilExists(timeout: 8)
            .tap()
        return SearchPageObject(app: app)
    }
}
