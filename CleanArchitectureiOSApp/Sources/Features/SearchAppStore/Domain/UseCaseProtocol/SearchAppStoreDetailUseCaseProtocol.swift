//
//  SearchAppStoreDetailUseCaseProtocol.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/18/26.
//

import Foundation
import Combine

protocol SearchAppStoreDetailUseCaseProtocol {
    func execute(trackId: Int) async throws -> SearchAppStoreDetailEntity
}
