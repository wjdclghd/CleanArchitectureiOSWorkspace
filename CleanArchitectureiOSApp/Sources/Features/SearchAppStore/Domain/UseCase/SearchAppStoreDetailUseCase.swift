//
//  SearchAppStoreDetailUseCase.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/18/26.
//

import Foundation
import Combine

final class SearchAppStoreDetailUseCase: SearchAppStoreDetailUseCaseProtocol {
    private let repository: SearchAppStoreDetailRepositoryProtocol
    
    init(repository: SearchAppStoreDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(trackId: Int) -> AnyPublisher<SearchAppStoreDetailEntity, any Error> {
        repository.fetchSearchAppStoreDetail(trackId: trackId)
    }
}
