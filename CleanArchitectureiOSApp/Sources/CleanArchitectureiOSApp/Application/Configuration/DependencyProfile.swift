//
//  DependencyProfile.swift
//  CleanArchitectureiOSApp
//
//  Created by Codex on 5/6/26.
//

import Foundation

enum DependencyProfile: Equatable {
    case local
    case development
    case staging
    case production
    case uiTestStub(UITestScenario)

    static func resolve(from configuration: AppLaunchConfiguration) -> DependencyProfile {
        if configuration.isUITesting {
            return .uiTestStub(UITestScenario.resolve(from: configuration))
        }

        if let rawValue = configuration.dependencyProfileName,
           rawValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            return resolve(fromRawValue: rawValue)
        }

        #if DEBUG
        return .local
        #else
        return .production
        #endif
    }

    private static func resolve(fromRawValue rawValue: String) -> DependencyProfile {
        switch rawValue.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
        case "local":
            return .local
        case "development", "dev":
            return .development
        case "staging", "stage":
            return .staging
        case "production", "prod":
            return .production
        default:
            preconditionFailure("Unsupported dependency profile: \(rawValue)")
        }
    }
}
