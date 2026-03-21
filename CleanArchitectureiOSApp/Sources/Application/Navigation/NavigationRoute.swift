//
//  NavigationRoute.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 12/19/25.
//

import Foundation

enum NavigationRoute: Hashable, Identifiable {
    case searchAppStoreListView(searchKeyword: String)
    case searchAppStoreDetailView(trackId: Int)
    
    var id: String {
        switch self {
        case .searchAppStoreListView(let searchKeyword):
            return "searchAppStoreListView-\(searchKeyword)"
        case .searchAppStoreDetailView(let trackId):
            return "searchAppStoreDetailView-\(trackId)"
        }
    }
}
