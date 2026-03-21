//
//  SearchAppStoreDetailRepositoryProtocol.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/18/26.
//

import Foundation
import Combine

protocol SearchAppStoreDetailRepositoryProtocol {
    func fetchSearchAppStoreDetail(trackId: Int) -> AnyPublisher<SearchAppStoreDetailEntity, Error>
}
