//
//  UITestScenario.swift
//  CleanArchitectureiOSApp
//
//  Created by Codex on 5/6/26.
//

import Foundation

enum UITestScenario: Equatable {
    case searchSuccess
    case loginSuccess
    
    var storageKey: String {
        switch self {
        case .searchSuccess:
            return "searchSuccess"
        case .loginSuccess:
            return "loginSuccess"
        }
    }

    static func resolve(from configuration: AppLaunchConfiguration) -> UITestScenario {
        if configuration.stubLoginSuccess {
            return .loginSuccess
        }

        if configuration.stubSearchSuccess {
            return .searchSuccess
        }

        return .searchSuccess
    }
}
