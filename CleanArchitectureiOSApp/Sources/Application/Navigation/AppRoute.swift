//
//  AppRoute.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 12/19/25.
//

import Foundation

enum AppRoute: Hashable, Identifiable {
    case main
//    case searchList
//    case searchDetailList(searchKeyword: String)
//    case searchDetail(entity: SearchDetailEntity)
//    case chatGPTSearch
//    case userRecommendation
    
    var id: String {
        switch self {
        case .main:
            return "main"
//        case .searchList:
//            return "searchList"
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
