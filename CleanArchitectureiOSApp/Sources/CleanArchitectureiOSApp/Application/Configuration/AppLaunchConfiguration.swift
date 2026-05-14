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
    let stubLoginSuccess: Bool

    /// local / development / staging / production
    let dependencyProfileName: String?

    /// Scheme Environment 또는 Info.plist에서 주입받은 Auth API baseURL입니다.
    let authBaseURLString: String?

    /// Scheme Environment 또는 Info.plist에서 주입받은 App Store Search API baseURL입니다.
    let searchAppStoreBaseURLString: String?

    static func current(
        arguments: [String] = ProcessInfo.processInfo.arguments,
        processEnvironment: [String: String] = ProcessInfo.processInfo.environment,
        infoDictionary: [String: Any] = Bundle.main.infoDictionary ?? [:]
    ) -> AppLaunchConfiguration {
        AppLaunchConfiguration(
            isUITesting: arguments.contains(UITestLaunchArgument.uiTesting)
                || processEnvironment.isEnabled(UITestLaunchEnvironment.uiTesting),
            shouldResetState: arguments.contains(UITestLaunchArgument.resetState)
                || processEnvironment.isEnabled(UITestLaunchEnvironment.resetState),
            stubSearchSuccess: arguments.contains(UITestLaunchArgument.stubSearchSuccess)
                || processEnvironment.isEnabled(UITestLaunchEnvironment.stubSearchSuccess),
            stubLoginSuccess: arguments.contains(UITestLaunchArgument.stubLoginSuccess)
                || processEnvironment.isEnabled(UITestLaunchEnvironment.stubLoginSuccess),
            dependencyProfileName: Self.configurationValue(
                key: AppEnvironmentKey.dependencyProfile,
                processEnvironment: processEnvironment,
                infoDictionary: infoDictionary
            ),
            authBaseURLString: Self.configurationValue(
                key: AppEnvironmentKey.authBaseURL,
                processEnvironment: processEnvironment,
                infoDictionary: infoDictionary
            ),
            searchAppStoreBaseURLString: Self.configurationValue(
                key: AppEnvironmentKey.searchAppStoreBaseURL,
                processEnvironment: processEnvironment,
                infoDictionary: infoDictionary
            )
        )
    }

    private static func configurationValue(
        key: String,
        processEnvironment: [String: String],
        infoDictionary: [String: Any]
    ) -> String? {
        if let value = processEnvironment[key],
           value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            return value
        }

        if let value = infoDictionary[key] as? String,
           value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            return value
        }

        return nil
    }
}

enum UITestLaunchArgument {
    static let uiTesting = "--ui-testing"
    static let resetState = "--reset-state"
    static let stubSearchSuccess = "--stub-search-success"
    static let stubLoginSuccess = "--stub-login-success"
}

enum UITestLaunchEnvironment {
    static let uiTesting = "UI_TESTING"
    static let resetState = "UI_TEST_RESET_STATE"
    static let stubSearchSuccess = "UI_TEST_STUB_SEARCH_SUCCESS"
    static let stubLoginSuccess = "UI_TEST_STUB_LOGIN_SUCCESS"
}

private extension Dictionary where Key == String, Value == String {
    func isEnabled(_ key: String) -> Bool {
        guard let value = self[key] else {
            return false
        }

        return ["1", "true", "TRUE"].contains(value)
    }
}


