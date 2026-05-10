//
//  SearchPageObject.swift
//  CleanArchitectureiOSAppUITests
//
//  Created by Codex on 5/6/26.
//

import XCTest

struct SearchPageObject {
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    func enterKeyword(_ keyword: String) {
        let input = app.descendants(matching: .any)[UITestAccessibilityIdentifier.Search.input]
            .waitUntilExists()
        input.tap()
        input.typeText(keyword)
    }

    func tapCandidate(keyword: String) -> SearchResultPageObject {
        app.buttons[UITestAccessibilityIdentifier.Search.candidate(keyword: keyword)]
            .waitUntilExists()
            .tap()
        return SearchResultPageObject(app: app)
    }
}
