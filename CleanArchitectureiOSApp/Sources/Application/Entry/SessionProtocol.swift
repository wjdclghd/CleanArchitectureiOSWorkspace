//
//  SessionProtocol.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/12/26.
//

import Foundation

protocol SessionProtocol {
    func loadSessionState() -> SessionState
    func completeFirstLaunch()
    func setLoggedIn()
    func setLoggedOut()
}
