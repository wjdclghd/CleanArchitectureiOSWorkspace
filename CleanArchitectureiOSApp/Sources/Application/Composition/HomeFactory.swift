//
//  HomeFactory.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 12/19/25.
//

import Foundation
import SwiftUI

enum HomeFactory {
    static func homeView(coordinator: NavigationCoordinator, onLogout: @escaping () -> Void) -> some View {
        HomeView(coordinator: coordinator, onLogout: onLogout)
    }
}
