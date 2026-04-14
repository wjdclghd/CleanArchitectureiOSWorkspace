//
//  DIContainer.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import Foundation
import Networking

struct DIContainer {
    let appConfiguration: AppConfigurationProtocol
    let sessionController: SessionController
    let searchAppStoreListUseCase: SearchAppStoreListUseCaseProtocol
    let searchAppStoreDetailUseCase: SearchAppStoreDetailUseCaseProtocol
}

extension DIContainer {
    @MainActor
    static func makeDefault() -> DIContainer {
        let appConfiguration: AppConfigurationProtocol = DebugAppConfiguration()
        let sessionController = SessionController()

        let requestBuilder = NetworkRequestBuilder()
        let networkClient: NetworkClientProtocol = URLSessionNetworkClient(
            requestBuilder: requestBuilder
        )

        let appStoreDataSource: AppStoreDataSourceProtocol = AppStoreDataSource(
            networkClient: networkClient
        )

        let searchAppStoreListRepository: SearchAppStoreListRepositoryProtocol = SearchAppStoreListRepository(
            dataSource: appStoreDataSource
        )
        let searchAppStoreListUseCase: SearchAppStoreListUseCaseProtocol = SearchAppStoreListUseCase(
            repository: searchAppStoreListRepository
        )

        let searchAppStoreDetailRepository: SearchAppStoreDetailRepositoryProtocol = SearchAppStoreDetailRepository(
            dataSource: appStoreDataSource
        )
        let searchAppStoreDetailUseCase: SearchAppStoreDetailUseCaseProtocol = SearchAppStoreDetailUseCase(
            repository: searchAppStoreDetailRepository
        )

        return DIContainer(
            appConfiguration: appConfiguration,
            sessionController: sessionController,
            searchAppStoreListUseCase: searchAppStoreListUseCase,
            searchAppStoreDetailUseCase: searchAppStoreDetailUseCase
        )
    }
}
