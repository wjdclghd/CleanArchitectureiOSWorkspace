//
//  NavigationRoute.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 12/19/25.
//

import Foundation

enum NavigationRoute: Hashable, Identifiable {
    case searchAppStoreListView(searchKeyword: String)
//    case searchDetailList(searchKeyword: String)
//    case searchDetail(entity: SearchDetailEntity)
//    case chatGPTSearch
//    case userRecommendation
    
    var id: String {
        switch self {
        case .searchAppStoreListView(let searchKeyword):
            return "searchAppStoreListView"
//        case .searchDetailList(let keyword):
//            return "searchDetailList-\(keyword)"
//        case .searchDetail(let entity):
//            return "searchDetail-\(SearchDetailEntity)"
//        case .chatGPTSearch:
//            return "chatGPTSearch"
//        case .userRecommendation:
//            return "userRecommendation"
        }
    }
}
