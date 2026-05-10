//
//  CleanArchitectureiOSApp.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 12/19/25.
//

import Foundation
import SwiftUI

@main
struct CleanArchitectureiOSApp: App {
    init() {
        AppAppearanceConfigurator.configure()
    }

    var body: some Scene {
        WindowGroup {
            AppRootView()
        }
    }
}
