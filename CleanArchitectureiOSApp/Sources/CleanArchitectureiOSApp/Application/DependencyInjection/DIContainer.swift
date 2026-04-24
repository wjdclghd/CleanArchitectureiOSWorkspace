//
//  DIContainer.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import Foundation
import Networking
import AppDomain
import AppData

/*
 App 레이어의 composition root입니다.

 이 타입은 AppConfiguration, session controller, networking concrete,
 AppData repository concrete, AppDomain use case concrete를 조립하여
 App 전체에서 사용할 의존성을 한 곳에서 제공합니다.

 담당 역할
 - App 전역 설정 생성
 - SessionController 생성
 - Networking concrete 생성
 - AppData concrete 생성
 - AppDomain concrete 생성
 - App 레이어가 사용할 의존성 묶음 제공

 담당하지 않는 역할
 - Feature 내부 View / ViewModel 생성
 - Feature 간 화면 이동 결정
 - 비즈니스 입력 검증
 */
struct DIContainer {
    let appConfiguration: DebugAppConfiguration
    let sessionController: SessionController
    let networkClient: URLSessionNetworkClient
    
    typealias SearchAppStoreRemoteDataSource = SearchAppStoreDataSource<URLSessionNetworkClient>
    typealias SearchAppStoreListRepositoryType = SearchAppStoreListRepository<SearchAppStoreRemoteDataSource>
    typealias SearchAppStoreDetailRepositoryType = SearchAppStoreDetailRepository<SearchAppStoreRemoteDataSource>
    typealias SearchAppStoreListUseCaseType = SearchAppStoreListUseCase<SearchAppStoreListRepositoryType>
    typealias SearchAppStoreDetailUseCaseType = SearchAppStoreDetailUseCase<SearchAppStoreDetailRepositoryType>
}

extension DIContainer {
    /*
     기본 App 의존성 그래프를 생성합니다.

     조립 순서
     1. App configuration 생성
     2. SessionController 생성
     3. URLSession 기반 NetworkClient 생성

     Returns:
     - 앱 실행에 필요한 기본 DIContainer
     */
    @MainActor
    static func makeDefault() -> DIContainer {
        let networkRequestBuilder = NetworkRequestBuilder()
        let networkClient = URLSessionNetworkClient(
            requestBuilder: networkRequestBuilder
        )

        return DIContainer(
            appConfiguration: DebugAppConfiguration(),
            sessionController: SessionController(),
            networkClient: networkClient
        )
    }

    /*
     SearchAppStore 목록 조회 유스케이스를 생성합니다.

     Returns:
     - 목록 조회 화면에서 사용할 SearchAppStoreListUseCase
     */
    func makeSearchAppStoreListUseCase() -> SearchAppStoreListUseCaseType {
            let repository = makeSearchAppStoreListRepository()
            return SearchAppStoreListUseCase(repository: repository)
        }

    /*
     SearchAppStore 상세 조회 유스케이스를 생성합니다.

     Returns:
     - 상세 조회 화면에서 사용할 SearchAppStoreDetailUseCase
     */
    func makeSearchAppStoreDetailUseCase() -> SearchAppStoreDetailUseCaseType {
            let repository = makeSearchAppStoreDetailRepository()
            return SearchAppStoreDetailUseCase(repository: repository)
        }
}

private extension DIContainer {
    /*
     SearchAppStore 원격 데이터 소스를 생성합니다.

     Returns:
     - SearchAppStoreDataSource
     */
    func makeSearchAppStoreRemoteDataSource() -> SearchAppStoreRemoteDataSource {
            SearchAppStoreDataSource(
                networkClient: networkClient
            )
        }

    /*
     SearchAppStore 목록 조회 Repository를 생성합니다.

     Returns:
     - SearchAppStoreListRepository
     */
    func makeSearchAppStoreListRepository() -> SearchAppStoreListRepositoryType {
            SearchAppStoreListRepository(
                dataSource: makeSearchAppStoreRemoteDataSource()
            )
        }

    /*
     SearchAppStore 상세 조회 Repository를 생성합니다.

     Returns:
     - SearchAppStoreDetailRepository
     */
    func makeSearchAppStoreDetailRepository() -> SearchAppStoreDetailRepositoryType {
            SearchAppStoreDetailRepository(
                dataSource: makeSearchAppStoreRemoteDataSource()
            )
        }
}
