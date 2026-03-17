//
//  UserDefaultsSession.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/12/26.
//

import Foundation

final class UserDefaultsSession: SessionProtocol {
    private enum Keys {
        static let completedFirstLaunch = "completedFirstLaunch"
        static let isLogged = "isLogged"
    }
    
    private let userDefaults: UserDefaults
    private let isIntroEnabled: Bool
    
    init(userDefaults: UserDefaults, isIntroEnabled: Bool) {
        self.userDefaults = userDefaults
        self.isIntroEnabled = isIntroEnabled
    }
    
    func loadSessionState() -> SessionState {
        if isIntroEnabled {
            let completedFirstLaunch = userDefaults.bool(forKey: Keys.completedFirstLaunch)
            
            if !completedFirstLaunch {
                return .firstLaunch
            }
        }
        
        let isLogged = userDefaults.bool(forKey: Keys.isLogged)
        
        return isLogged ? .loggedIn : .loggedOut
    }
    
    func completeFirstLaunch() {
        userDefaults.set(true, forKey: Keys.completedFirstLaunch)
    }
    
    func setLoggedIn() {
        userDefaults.set(true, forKey: Keys.isLogged)
    }
    
    func setLoggedOut() {
        userDefaults.set(false, forKey: Keys.isLogged)
    }
}
