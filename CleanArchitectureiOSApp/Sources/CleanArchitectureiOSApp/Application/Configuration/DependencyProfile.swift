//
//  DependencyProfile.swift
//  CleanArchitectureiOSApp
//
//  Created by Codex on 5/6/26.
//

import Foundation

enum DependencyProfile: Equatable {
    case production
    case uiTestStub(UITestScenario)

    static func resolve(from configuration: AppLaunchConfiguration) -> DependencyProfile {
        guard configuration.isUITesting else {
            return .production
        }

        return .uiTestStub(UITestScenario.resolve(from: configuration))
    }
}
