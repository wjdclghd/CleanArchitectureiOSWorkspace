//
//  AppStoreDataSource.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/26/26.
//

import Foundation
import Networking

final class AppStoreDataSource: AppStoreDataSourceProtocol {
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func fetchSearchAppStoreListResults(searchKeyword: String) async throws -> SearchAppStoreResponseDTO {
        let endpoint = AppStoreEndpoint.searchList(searchKeyword: searchKeyword)
        return try await networkClient.request(endpoint, as: SearchAppStoreResponseDTO.self)
    }

    func fetchSearchAppStoreDetailResults(trackId: Int) async throws -> SearchAppStoreResponseDTO {
        let endpoint = AppStoreEndpoint.detail(trackId: trackId)
        return try await networkClient.request(endpoint, as: SearchAppStoreResponseDTO.self)
    }
}
