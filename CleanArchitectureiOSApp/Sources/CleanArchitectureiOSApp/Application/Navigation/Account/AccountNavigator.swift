//
//  AccountNavigator.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import Foundation
import Navigation

@MainActor
final class AccountNavigator {
    private let navigator: Navigator<AccountRoute>

    init(navigator: Navigator<AccountRoute>) {
        self.navigator = navigator
    }

    func showSettings() {
        navigator.push(.settings)
    }

    func pop() {
        navigator.pop()
    }

    func popToRoot() {
        navigator.popToRoot()
    }
}
