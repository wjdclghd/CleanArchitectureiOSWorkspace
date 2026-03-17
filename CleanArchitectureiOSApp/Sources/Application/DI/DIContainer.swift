//
//  DIContainer.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 12/19/25.
//

import Foundation
import CoreDatabase
import CoreNetwork
//import AppStoreAPIModule
//import ChatGPTAPIModule
//import UserRecommendationModule
//import AIModule

struct DIContainer {
    let appConfiguration: AppConfigurationProtocol
    let sessionState: SessionProtocol
    let launchDecider: LaunchDecider
//    let searchListUseCase: SearchListUseCaseProtocol
//    let searchDetailListUseCase: (_ searchKeyword: String) -> SearchDetailListUseCaseProtocol
//    let chatGPTSearchUseCase: ChatGPTSearchUseCaseProtocol
//    let userRecommendationUseCase: UserRecommendationUseCaseProtocol
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
        
//        let searchListRepository: SearchListRepositoryProtocol = SearchListRepository(realmSwiftDBSearchListProtocol: realmSwiftDBSearchList)
//        let searchListUseCase: SearchListUseCaseProtocol = SearchListUseCase(repository: searchListRepository)
//        
//        let searchDetailListUseCase: (_ searchKeyword: String) -> SearchDetailListUseCaseProtocol = { searchKeyword in
//            let searchDetailListRepository: SearchDetailListRepositoryProtocol = SearchDetailListRepository(networkServiceProtocol: networkService)
//            
//            return SearchDetailListUseCase(repository: searchDetailListRepository)
//        }
//        
//        let chatGPTSearchRepository: ChatGPTSearchRepositoryProtocol = ChatGPTSearchRepository(networkServiceProtocol: networkService)
//        let chatGPTSearchUseCase: ChatGPTSearchUseCaseProtocol = ChatGPTSearchUseCase(repository: chatGPTSearchRepository)
//        
//        let userRecommendationEngine: UserRecommendationEngineProtocol
//        
//        do {
//            userRecommendationEngine = try UserRecommendationEngine()
//        } catch {
//            fatalError("UserRecommendationEngine 초기화 실패: \(error)")
//        }
//        
//        let userRecommendationRepository: UserRecommendationRepositoryProtocol = UserRecommendationRepository(engineProtocol: userRecommendationEngine)
//        let userRecommendationUseCase: UserRecommendationUseCaseProtocol = UserRecommendationUseCase(repository: userRecommendationRepository)

        return DIContainer(
            appConfiguration: appConfiguration,
            sessionState: sessionState,
            launchDecider: launchDecider
//            searchListUseCase: searchListUseCase,
//            searchDetailListUseCase: searchDetailListUseCase,
//            chatGPTSearchUseCase: chatGPTSearchUseCase,
//            userRecommendationUseCase: userRecommendationUseCase
        )
    }
}
