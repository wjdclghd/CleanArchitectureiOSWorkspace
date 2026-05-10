//
//  AppLaunchConfiguration.swift
//  CleanArchitectureiOSApp
//
//  Created by Codex on 5/6/26.
//

import Foundation

struct AppLaunchConfiguration: Equatable {
    let isUITesting: Bool
    let shouldResetState: Bool
    let stubSearchSuccess: Bool

    static func current(
        arguments: [String] = ProcessInfo.processInfo.arguments,
        environment: [String: String] = ProcessInfo.processInfo.environment
    ) -> AppLaunchConfiguration {
        return AppLaunchConfiguration(
            isUITesting: arguments.contains(UITestLaunchArgument.uiTesting)
                || environment.isEnabled(UITestLaunchEnvironment.uiTesting),
            shouldResetState: arguments.contains(UITestLaunchArgument.resetState)
                || environment.isEnabled(UITestLaunchEnvironment.resetState),
            stubSearchSuccess: arguments.contains(UITestLaunchArgument.stubSearchSuccess)
                || environment.isEnabled(UITestLaunchEnvironment.stubSearchSuccess)
        )
    }
}

enum UITestLaunchArgument {
    static let uiTesting = "--ui-testing"
    static let resetState = "--reset-state"
    static let stubSearchSuccess = "--stub-search-success"
}

enum UITestLaunchEnvironment {
    static let uiTesting = "UI_TESTING"
    static let resetState = "UI_TEST_RESET_STATE"
    static let stubSearchSuccess = "UI_TEST_STUB_SEARCH_SUCCESS"
}

private extension Dictionary where Key == String, Value == String {
    func isEnabled(_ key: String) -> Bool {
        guard let value = self[key] else {
            return false
        }

        return ["1", "true", "TRUE"].contains(value)
    }
}
