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
//    let searchListUseCase: SearchListUseCaseProtocol
//    let searchDetailListUseCase: (_ searchKeyword: String) -> SearchDetailListUseCaseProtocol
//    let chatGPTSearchUseCase: ChatGPTSearchUseCaseProtocol
//    let userRecommendationUseCase: UserRecommendationUseCaseProtocol
}

extension DIContainer {
//    static func makeDefault() -> DIContainer {
//        let realmSwiftDBSearchList: RealmSwiftDBSearchListProtocol = try! RealmSwiftDBSearchList()
//        
//        let networkService: NetworkServiceProtocol = NetworkService(
//            kakaoKey: Bundle.main.infoDictionary?["KAKAO_REST_API_KEY"] as? String
////            let apiKey = Bundle.main.infoDictionary?["CHAT_GPT_API_KEY"] as? String
//        )
//        
//        print("KAKAO_REST_API_KEY =", Bundle.main.infoDictionary?["KAKAO_REST_API_KEY"] as? String ?? "nil")
//        
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
//
//        return DIContainer(
//            searchListUseCase: searchListUseCase,
//            searchDetailListUseCase: searchDetailListUseCase,
//            chatGPTSearchUseCase: chatGPTSearchUseCase,
//            userRecommendationUseCase: userRecommendationUseCase
//        )
//    }
}
