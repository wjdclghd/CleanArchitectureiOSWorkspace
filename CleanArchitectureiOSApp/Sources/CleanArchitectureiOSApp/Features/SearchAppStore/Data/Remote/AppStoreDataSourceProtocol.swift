//
//  AppStoreDataSourceProtocol.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/26/26.
//

import Foundation

protocol AppStoreDataSourceProtocol {
    func fetchSearchAppStoreListResults(searchKeyword: String) async throws -> SearchAppStoreResponseDTO
    func fetchSearchAppStoreDetailResults(trackId: Int) async throws -> SearchAppStoreResponseDTO
}
