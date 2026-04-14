//
//  CleanArchitectureiOSApp.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 12/19/25.
//

import Foundation
import SwiftUI
//import Persistence

@main
struct CleanArchitectureiOSApp: App {
    private let container: DIContainer
    
    init() {
//        let migration: RealmSwiftDBMigrationProtocol = RealmSwiftDBMigration()
//        migration.configuration()
        
        self.container = DIContainer.makeDefault()
    }
    
    var body: some Scene {
        WindowGroup {
            AppRootView(container: container)
        }
    }
}
