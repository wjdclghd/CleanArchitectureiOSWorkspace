//
//  XCUIApplication+Launch.swift
//  CleanArchitectureiOSAppUITests
//
//  Created by Codex on 5/6/26.
//

import XCTest

extension XCUIApplication {
    func launchForUITest(
        arguments: [String] = [],
        environment: [String: String] = [:]
    ) {
        launchArguments = [UITestLaunchArgument.uiTesting] + arguments
        launchEnvironment = [
            UITestLaunchEnvironment.uiTesting: "1"
        ].merging(environment) { _, newValue in newValue }
        launch()
    }
}
