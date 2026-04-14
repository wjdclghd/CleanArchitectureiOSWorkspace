//
//  SearchAppStoreUseCase.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/17/26.
//

import Foundation

final class SearchAppStoreListUseCase: SearchAppStoreListUseCaseProtocol {
    private let repository: SearchAppStoreListRepositoryProtocol

    init(repository: SearchAppStoreListRepositoryProtocol) {
        self.repository = repository
    }

    func execute(searchKeyword: String) async throws -> [SearchAppStoreListEntity] {
        let trimmed = searchKeyword.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmed.isEmpty else {
            return []
        }

        return try await repository.fetchSearchAppStoreList(searchKeyword: trimmed)
    }
}
