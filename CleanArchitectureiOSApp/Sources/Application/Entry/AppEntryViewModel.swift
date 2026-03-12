//
//  AppEntryViewModel.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/6/26.
//

import Foundation
import SwiftUI

final class AppEntryViewModel: ObservableObject {
    private let launchDecider: LaunchDecider
    
    @Published private(set) var appEntryState: AppEntryState
    
    init(launchDecider: LaunchDecider, sessionState: SessionState) {
        self.launchDecider = launchDecider
        self.appEntryState = launchDecider.decide(from: sessionState)
    }
    
    func completeIntro() {
        appEntryState = .login
    }
    
    func loginSucceeded() {
        appEntryState = .home
    }
    
    func logout() {
        appEntryState = .login
    }
}
