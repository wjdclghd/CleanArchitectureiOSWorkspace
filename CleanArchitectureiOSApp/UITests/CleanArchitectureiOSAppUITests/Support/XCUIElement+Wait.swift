//
//  XCUIElement+Wait.swift
//  CleanArchitectureiOSAppUITests
//
//  Created by Codex on 5/6/26.
//

import XCTest

extension XCUIElement {
    @discardableResult
    func waitUntilExists(
        timeout: TimeInterval = 5,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> XCUIElement {
        XCTAssertTrue(
            waitForExistence(timeout: timeout),
            "Expected element to exist: \(self)",
            file: file,
            line: line
        )
        return self
    }
}
