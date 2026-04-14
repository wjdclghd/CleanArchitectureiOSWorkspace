//
//  SearchAppStoreDetailRepositoryProtocol.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/18/26.
//

import Foundation

protocol SearchAppStoreDetailRepositoryProtocol {
    func fetchSearchAppStoreDetail(trackId: Int) async throws -> SearchAppStoreDetailEntity
}
