//
//  SearchAppStoreRepository.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/17/26.
//

import Foundation
import Combine
import CoreNetwork

final class SearchAppStoreListRepository: SearchAppStoreListRepositoryProtocol {
    private let networkServiceProtocol: NetworkServiceProtocol

    init(networkServiceProtocol: NetworkServiceProtocol) {
        self.networkServiceProtocol = networkServiceProtocol
    }

    func fetchSearchAppStoreListResults(searchKeyword: String) -> AnyPublisher<[SearchAppStoreListEntity], Error> {
        networkServiceProtocol.request(
            .searchDetailList(searchKeyword: searchKeyword), type: SearchAppStoreResponseDTO.self
        )
        .map { response in
            response.results.map {
                SearchAppStoreDTOMapper.toListItemEntity(from: $0)
            }
        }
        .mapError { $0 as Error }
        .eraseToAnyPublisher()
    }
}
