//
//  SearchAppStoreRepositoryProtocol.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/17/26.
//

import Foundation
import Combine

protocol SearchAppStoreListRepositoryProtocol {
    func fetchSearchAppStoreListResults(searchKeyword: String) -> AnyPublisher<[SearchAppStoreListEntity], Error>
}
