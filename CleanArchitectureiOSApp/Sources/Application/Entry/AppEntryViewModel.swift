//
//  AppEntryViewModel.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/6/26.
//

import Foundation
import SwiftUI

final class AppEntryViewModel: ObservableObject {
    private let sessionState: SessionProtocol
    private let launchDecider: LaunchDecider
    
    @Published private(set) var appEntryState: AppEntryState
    
    init(sessionState: SessionProtocol, launchDecider: LaunchDecider) {
        self.sessionState = sessionState
        self.launchDecider = launchDecider
        
        let sessionState = sessionState.loadSessionState()
        self.appEntryState = launchDecider.decide(from: sessionState)
    }
    
    func completeIntro() {
        sessionState.completeFirstLaunch()
        appEntryState = .login
    }
    
    func loginSucceeded() {
        sessionState.setLoggedIn()
        appEntryState = .home
    }
    
    func logout() {
        sessionState.setLoggedOut()
        appEntryState = .login
    }
}
