//
//  SearchAppStoreDetailRepository.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/18/26.
//

import Foundation
import Networking

final class SearchAppStoreDetailRepository: SearchAppStoreDetailRepositoryProtocol {
    private let dataSource: AppStoreDataSourceProtocol

    init(dataSource: AppStoreDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func fetchSearchAppStoreDetail(trackId: Int) async throws -> SearchAppStoreDetailEntity {
        let response = try await dataSource.fetchSearchAppStoreDetailResults(trackId: trackId)

        guard let item = response.results.first else {
            throw NetworkError.emptyResponse
        }

        return SearchAppStoreDTOMapper.toDetailEntity(from: item)
    }
}
