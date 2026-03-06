//
//  CleanArchitectureiOSApp.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 12/19/25.
//

import Foundation
import SwiftUI
import CoreDatabase

@main
struct CleanSprintApp: App {
//    private let container = DIContainer.makeDefault()
    
    init() {
        let migration: RealmSwiftDBMigrationProtocol = RealmSwiftDBMigration()
        migration.configuration()
    }
    
    var body: some Scene {
        WindowGroup {
//            AppEntryView(container: container)
        }
    }
}
