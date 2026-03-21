//
//  DIContainer.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 12/19/25.
//

import Foundation
import CoreDatabase
import CoreNetwork

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
        
        let realmSwiftDBSearchList: RealmSwiftDBSearchListProtocol = try! RealmSwiftDBSearchList()
        
        let networkService: NetworkServiceProtocol = NetworkService(
            apiKey: appConfiguration.kakaoRESTAPIKey
        )
        
        let searchAppStoreListRepository: SearchAppStoreListRepositoryProtocol = SearchAppStoreListRepository(networkServiceProtocol: networkService)
        let searchAppStoreListUseCase: SearchAppStoreListUseCaseProtocol = SearchAppStoreListUseCase(repository: searchAppStoreListRepository)
        
        let searchAppStoreDetailRepository: SearchAppStoreDetailRepositoryProtocol = SearchAppStoreDetailRepository(networkServiceProtocol: networkService)
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
