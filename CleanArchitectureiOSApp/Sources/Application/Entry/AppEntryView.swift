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
    
    init(container: DIContainer, viewModel: AppEntryViewModel) {
        self.container = container
        
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            switch viewModel.appEntryState {
            case .intro:
                IntroView(
                    onNext: {
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
