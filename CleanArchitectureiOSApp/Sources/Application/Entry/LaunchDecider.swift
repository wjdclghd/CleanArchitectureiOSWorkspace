//
//  LaunchDecider.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/6/26.
//

import Foundation

struct LaunchDecider {
    func decide(from sessionState: SessionState) -> AppEntryState {
        switch sessionState {
        case .firstLaunch:
            return .intro
        case .loggedOut:
            return .login
        case .loggedIn:
            return .home
        }
    }
}
