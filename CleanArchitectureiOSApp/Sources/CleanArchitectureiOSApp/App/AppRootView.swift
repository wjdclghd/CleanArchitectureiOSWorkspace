//
//  AppRootView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/11/26.
//

import Foundation
import SwiftUI

struct AppRootView: View {
    private let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        AppFlowView(
            container: container,
            viewModel: AppFlowViewModel()
        )
    }
}
