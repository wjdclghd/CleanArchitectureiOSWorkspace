//
//  EntryFactory.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/17/26.
//

import Foundation
import SwiftUI

enum EntryFactory {
    static func appEntryView(container: DIContainer) -> some View {
        let viewModel = AppEntryViewModel(sessionState: container.sessionState, launchDecider: container.launchDecider)
        
        return AppEntryView(container: container, viewModel: viewModel)
    }
}
