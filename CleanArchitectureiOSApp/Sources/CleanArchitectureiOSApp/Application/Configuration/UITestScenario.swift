//
//  UITestScenario.swift
//  CleanArchitectureiOSApp
//
//  Created by Codex on 5/6/26.
//

import Foundation

enum UITestScenario: Equatable {
    case searchSuccess

    static func resolve(from configuration: AppLaunchConfiguration) -> UITestScenario {
        if configuration.stubSearchSuccess {
            return .searchSuccess
        }

        return .searchSuccess
    }
}
