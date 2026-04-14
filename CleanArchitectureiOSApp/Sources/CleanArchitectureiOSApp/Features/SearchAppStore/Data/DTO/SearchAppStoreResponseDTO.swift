//
//  SearchAppStoreResponseDTO.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/18/26.
//

import Foundation

struct SearchAppStoreResponseDTO: Codable {
    let resultCount: Int
    let results: [SearchAppStoreItemDTO]
}
