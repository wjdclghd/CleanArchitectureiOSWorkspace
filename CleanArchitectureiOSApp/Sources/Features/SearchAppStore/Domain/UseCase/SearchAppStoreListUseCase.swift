//
//  SearchAppStoreUseCase.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/17/26.
//

import Foundation
import Combine

final class SearchAppStoreListUseCase: SearchAppStoreListUseCaseProtocol {
    private let repository: SearchAppStoreListRepositoryProtocol

    init(repository: SearchAppStoreListRepositoryProtocol) {
        self.repository = repository
    }

    func execute(searchKeyword: String) -> AnyPublisher<[SearchAppStoreListEntity], Error> {
        let trimmed = searchKeyword.trimmingCharacters(in: .whitespaces)
        
        guard !trimmed.isEmpty else {
            return Just([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return repository.fetchSearchAppStoreListResults(searchKeyword: trimmed)
    }
}
