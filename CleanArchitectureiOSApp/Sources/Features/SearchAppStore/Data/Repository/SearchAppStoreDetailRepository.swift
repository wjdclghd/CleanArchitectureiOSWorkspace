//
//  SearchAppStoreDetailRepository.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/18/26.
//

import Foundation
import Combine
import CoreNetwork
/*
final class SearchAppStoreDetailRepository: SearchAppStoreDetailRepositoryProtocol {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchSearchAppStoreDetail(trackId: Int) -> AnyPublisher<SearchAppStoreDetailEntity, any Error> {
        networkService.request(
            .searchDetail(trackId: trackId), type: SearchAppStoreResponseDTO.self
        )
        .tryMap { response in
            guard let entity = response.results.first else {
                throw NSError(domain: "SearchAppStoreDetailRepository", code: -1)
            }
            
            return SearchAppStoreDTOMapper.toDetailEntity(from: entity)
        }
        .mapError { $0 as Error }
        .eraseToAnyPublisher()
    }
}
*/
