//
//  DIContainer.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 12/19/25.
//

import Foundation
import Networking
//import Persistence

struct DIContainer {
    let appConfiguration: AppConfigurationProtocol
    let sessionState: SessionProtocol
    let launchDecider: LaunchDecider
    let searchAppStoreListUseCase: SearchAppStoreListUseCaseProtocol
    let searchAppStoreDetailUseCase: SearchAppStoreDetailUseCaseProtocol
}

extension DIContainer {
    static func makeDefault() -> DIContainer {
        let appConfiguration: AppConfigurationProtocol = DebugAppConfiguration()
        let sessionState: SessionProtocol = UserDefaultsSession(
            userDefaults: .standard,
            isIntroEnabled: false
        )
        let launchDecider = LaunchDecider()
        
//        let realmSwiftDBSearchList: RealmSwiftDBSearchListProtocol = try! RealmSwiftDBSearchList()
        
        let requestBuilder = NetworkRequestBuilder()
        let networkClient: NetworkClientProtocol = URLSessionNetworkClient(
            requestBuilder: requestBuilder
        )
        
        let appStoreDataSource: AppStoreDataSourceProtocol = AppStoreDataSource(
            networkClient: networkClient
        )
        
        let searchAppStoreListRepository: SearchAppStoreListRepositoryProtocol = SearchAppStoreListRepository(dataSource: appStoreDataSource)
        let searchAppStoreListUseCase: SearchAppStoreListUseCaseProtocol = SearchAppStoreListUseCase(repository: searchAppStoreListRepository)
        
        let searchAppStoreDetailRepository: SearchAppStoreDetailRepositoryProtocol = SearchAppStoreDetailRepository(dataSource: appStoreDataSource)
        let searchAppStoreDetailUseCase: SearchAppStoreDetailUseCaseProtocol = SearchAppStoreDetailUseCase(repository: searchAppStoreDetailRepository)

        return DIContainer(
            appConfiguration: appConfiguration,
            sessionState: sessionState,
            launchDecider: launchDecider,
            searchAppStoreListUseCase: searchAppStoreListUseCase,
            searchAppStoreDetailUseCase: searchAppStoreDetailUseCase
        )
    }
}
