//
//  SearchAppStoreRepository.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/17/26.
//

import Foundation

final class SearchAppStoreListRepository: SearchAppStoreListRepositoryProtocol {
    private let dataSource: AppStoreDataSourceProtocol

    init(dataSource: AppStoreDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func fetchSearchAppStoreList(searchKeyword: String) async throws -> [SearchAppStoreListEntity] {
        let response = try await dataSource.fetchSearchAppStoreListResults(searchKeyword: searchKeyword)

        return response.results.map {
            SearchAppStoreDTOMapper.toListItemEntity(from: $0)
        }
    }
}
