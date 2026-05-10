//
//  HomeRoute.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import Foundation

/// Home 화면 흐름에서 사용하는 route 경로입니다.
enum HomeRoute: Hashable, Identifiable {
    case search
    case searchAppStoreList(keyword: String)
    case searchAppStoreDetail(trackId: Int)

    var id: String {
        switch self {
        case .search:
            return "search.input"
        case .searchAppStoreList(let keyword):
            return "search.list.\(keyword)"
        case .searchAppStoreDetail(let trackId):
            return "search.detail.\(trackId)"
        }
    }
}
