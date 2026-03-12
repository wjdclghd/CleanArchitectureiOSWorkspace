//
//  NavigationRoute.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 12/19/25.
//

import Foundation

enum NavigationRoute: Hashable, Identifiable {
    case searchList
//    case searchDetailList(searchKeyword: String)
//    case searchDetail(entity: SearchDetailEntity)
//    case chatGPTSearch
//    case userRecommendation
    
    var id: String {
        switch self {
        case .searchList:
            return "searchList"
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
