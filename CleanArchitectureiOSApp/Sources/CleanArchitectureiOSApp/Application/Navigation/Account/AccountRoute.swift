//
//  AccountRoute.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import Foundation

/// Account 화면 흐름에서 사용하는 route 경로입니다.
enum AccountRoute: Hashable, Identifiable {
    case settings

    var id: String {
        switch self {
        case .settings:
            return "account.settings"
        }
    }
}
