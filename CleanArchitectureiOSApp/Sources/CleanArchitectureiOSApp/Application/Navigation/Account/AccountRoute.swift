//
//  AccountRoute.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import Foundation

enum AccountRoute: Hashable, Identifiable {
    case settings

    var id: String {
        switch self {
        case .settings:
            return "account.settings"
        }
    }
}
