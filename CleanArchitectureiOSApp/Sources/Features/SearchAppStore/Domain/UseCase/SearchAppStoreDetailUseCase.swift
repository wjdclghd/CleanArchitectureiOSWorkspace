//
//  SearchAppStoreDetailUseCase.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/18/26.
//

import Foundation

final class SearchAppStoreDetailUseCase: SearchAppStoreDetailUseCaseProtocol {
    private let repository: SearchAppStoreDetailRepositoryProtocol
    
    init(repository: SearchAppStoreDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(trackId: Int) async throws -> SearchAppStoreDetailEntity {
        try await repository.fetchSearchAppStoreDetail(trackId: trackId)
    }
}
