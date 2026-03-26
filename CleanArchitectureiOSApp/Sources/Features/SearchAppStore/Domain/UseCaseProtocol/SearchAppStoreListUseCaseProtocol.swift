//
//  SearchAppStoreUseCaseProtocol.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/17/26.
//

import Foundation
import Combine

protocol SearchAppStoreListUseCaseProtocol{
    func execute(searchKeyword: String) async throws -> [SearchAppStoreListEntity]
}
