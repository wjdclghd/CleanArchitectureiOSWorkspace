//
//  AppEntryView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 12/19/25.
//

import Foundation
import SwiftUI

struct AppEntryView: View {
    private let container: DIContainer
    
    @StateObject private var viewModel: AppEntryViewModel
    
    init(container: DIContainer) {
        self.container = container
        
        let launchDecider = LaunchDecider()
        let sessionState: SessionState = .loggedOut
        self._viewModel = StateObject(
            wrappedValue: AppEntryViewModel(launchDecider: launchDecider, sessionState: sessionState)
        )
    }
    
    var body: some View {
        Group {
            switch viewModel.appEntryState {
            case .intro:
                IntroView(
                    onLogin: {
                        viewModel.completeIntro()
                    }
                )
            case .login:
                LoginView(
                    onLoginSuccess: {
                        viewModel.loginSucceeded()
                    }
                )
            case .home:
                NavigationHostView(
                    container: container,
                    onLogout: {
                        viewModel.logout()
                    }
                )
            }
        }
    }
}
