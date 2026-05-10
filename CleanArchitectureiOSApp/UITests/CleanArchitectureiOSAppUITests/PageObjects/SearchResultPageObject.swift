//
//  SearchResultPageObject.swift
//  CleanArchitectureiOSAppUITests
//
//  Created by Codex on 5/6/26.
//

import XCTest

struct SearchResultPageObject {
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    func waitForResults() {
        app.buttons[UITestAccessibilityIdentifier.SearchResult.item(trackId: 1001)]
            .waitUntilExists()
    }

    func tapItem(trackId: Int) -> SearchDetailPageObject {
        let item = app.buttons[UITestAccessibilityIdentifier.SearchResult.item(trackId: trackId)]
            .waitUntilExists()
        item.coordinate(withNormalizedOffset: CGVector(dx: 0.25, dy: 0.5)).tap()
        return SearchDetailPageObject(app: app)
    }
}
