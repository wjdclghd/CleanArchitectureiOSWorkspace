//
//  AppEnvironment.swift
//  CleanArchitectureiOSApp
//
//  Created by Codex on 5/6/26.
//

import Foundation

struct AppEnvironment: Equatable {
    let launchConfiguration: AppLaunchConfiguration
    let dependencyProfile: DependencyProfile

    static func current() -> AppEnvironment {
        let launchConfiguration = AppLaunchConfiguration.current()

        return AppEnvironment(
            launchConfiguration: launchConfiguration,
            dependencyProfile: DependencyProfile.resolve(from: launchConfiguration)
        )
    }
}
