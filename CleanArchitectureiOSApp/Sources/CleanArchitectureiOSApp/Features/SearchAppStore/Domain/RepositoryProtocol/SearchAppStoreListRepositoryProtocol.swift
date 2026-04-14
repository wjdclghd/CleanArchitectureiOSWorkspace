//
//  SearchAppStoreRepositoryProtocol.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/17/26.
//

import Foundation
import Combine

protocol SearchAppStoreListRepositoryProtocol {
    func fetchSearchAppStoreList(searchKeyword: String) async throws -> [SearchAppStoreListEntity]
}
