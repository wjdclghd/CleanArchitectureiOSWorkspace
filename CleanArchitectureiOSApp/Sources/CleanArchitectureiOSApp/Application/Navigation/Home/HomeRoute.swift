//
//  HomeRoute.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import Foundation

enum HomeRoute: Hashable, Identifiable {
    case searchAppStoreList(keyword: String)
    case searchAppStoreDetail(trackId: Int)

    var id: String {
        switch self {
        case .searchAppStoreList(let keyword):
            return "search.list.\(keyword)"
        case .searchAppStoreDetail(let trackId):
            return "search.detail.\(trackId)"
        }
    }
}
