//
//  ProductionDependencyBuilder.swift
//  CleanArchitectureiOSApp
//
//  Created by Codex on 5/6/26.
//

import Foundation
import Networking
import Keychain
import Persistence
import SearchEngine
import AppDomain
import AppData

enum ProductionDependencyBuilder {

    @MainActor
    static func makeContainer(environment: AppEnvironment) async throws -> DIContainer {
        let coreDependencies = try await makeCoreDependencies()
        let authDependencies = makeAuthDependencies(coreDependencies: coreDependencies, environment: environment)
        let searchAppStoreRemoteDataSource = SearchAppStoreDataSource(
            networkClient: coreDependencies.networkClient,
            baseURL: environment.searchAppStoreBaseURL
        )
        let searchAppStoreListRepository = SearchAppStoreListRepository(
            dataSource: searchAppStoreRemoteDataSource
        )
        let searchAppStoreDetailRepository = SearchAppStoreDetailRepository(
            dataSource: searchAppStoreRemoteDataSource
        )
        let searchHistoryDataSource = SearchHistoryDataSource(
            store: AnySearchHistoryStore(
                coreDependencies.persistenceContainer.makeSearchHistoryStore()
            )
        )
        let searchHistoryRepository = SearchHistoryRepository(
            dataSource: searchHistoryDataSource
        )
        let searchSuggestionDataSource = SearchSuggestionDataSource(
            searchEngine: coreDependencies.searchEngine
        )
        let searchSuggestionRepository = SearchSuggestionRepository(
            dataSource: searchSuggestionDataSource
        )

        let sessionController = SessionController()
        let container = DIContainer(
            appConfiguration: DebugAppConfiguration(),
            appEnvironment: environment,
            sessionController: sessionController,
            networkClient: coreDependencies.networkClient,
            persistenceContainer: coreDependencies.persistenceContainer,
            searchEngineContainer: coreDependencies.searchEngineContainer,
            searchEngine: coreDependencies.searchEngine,
            loginUseCase: authDependencies.loginUseCase,
            sessionLogoutUseCase: authDependencies.sessionLogoutUseCase,
            refreshAuthTokenUseCase: authDependencies.refreshAuthTokenUseCase,
            searchAppStoreListUseCase: AnySearchAppStoreListUseCase(
                SearchAppStoreListUseCase(repository: searchAppStoreListRepository)
            ),
            searchAppStoreDetailUseCase: AnySearchAppStoreDetailUseCase(
                SearchAppStoreDetailUseCase(repository: searchAppStoreDetailRepository)
            ),
            searchHistoryUseCase: AnySearchHistoryUseCase(
                SearchHistoryUseCase(repository: searchHistoryRepository)
            ),
            searchCandidateUseCase: AnySearchCandidateUseCase(
                SearchCandidateUseCase(
                    historyRepository: searchHistoryRepository,
                    suggestionRepository: searchSuggestionRepository
                )
            )
        )

        try await indexSearchSuggestionSeeds(searchEngine: coreDependencies.searchEngine)
        await restoreSession(
            sessionController: sessionController,
            restorationUseCase: authDependencies.sessionRestorationUseCase
        )

        return container
    }
}

private extension ProductionDependencyBuilder {
    struct CoreDependencies {
        let networkClient: URLSessionNetworkClient
        let keychainContainer: KeychainContainer
        let persistenceContainer: PersistenceContainer
        let searchEngineContainer: SearchEngineContainer
        let searchEngine: AnySearchEngine
    }

    struct AuthDependencies {
        let loginUseCase: AnyLoginUseCase
        let sessionLogoutUseCase: AnySessionLogoutUseCase
        let refreshAuthTokenUseCase: AnyRefreshAuthTokenUseCase
        let sessionRestorationUseCase: any RestoreSessionUseCaseProtocol
    }

    static func makeCoreDependencies() async throws -> CoreDependencies {
        let networkRequestBuilder = NetworkRequestBuilder()
        let networkClient = URLSessionNetworkClient(
            requestBuilder: networkRequestBuilder
        )
        let keychainContainer = KeychainContainer()
        let persistenceContainer = try await PersistenceContainer.makeDefault()
        let searchEngineContainer = try SearchEngineContainer.makeDefault()
        let searchEngine = AnySearchEngine(searchEngineContainer.makeSearchEngine())

        return CoreDependencies(
            networkClient: networkClient,
            keychainContainer: keychainContainer,
            persistenceContainer: persistenceContainer,
            searchEngineContainer: searchEngineContainer,
            searchEngine: searchEngine
        )
    }

    static func makeAuthDependencies(
        coreDependencies: CoreDependencies,
        environment: AppEnvironment
    ) -> AuthDependencies {
        let authRemoteDataSource = AuthRemoteDataSource(
            networkClient: coreDependencies.networkClient,
            baseURL: environment.authBaseURL
        )
        let authTokenLocalDataSource = AuthTokenLocalDataSource(
            store: coreDependencies.keychainContainer.makeAuthTokenStore()
        )
        let authSessionLocalDataSource = AuthSessionLocalDataSource(
            store: coreDependencies.persistenceContainer.makeAuthSessionStore()
        )
        let authRepository = AuthRepository(
            remoteDataSource: authRemoteDataSource,
            tokenLocalDataSource: authTokenLocalDataSource,
            sessionLocalDataSource: authSessionLocalDataSource,
            environment: environment.authStorageKey
        )

        return AuthDependencies(
            loginUseCase: AnyLoginUseCase(
                LoginUseCase(repository: authRepository)
            ),
            sessionLogoutUseCase: AnySessionLogoutUseCase(
                LogoutSessionUseCase(repository: authRepository)
            ),
            refreshAuthTokenUseCase: AnyRefreshAuthTokenUseCase(
                RefreshAuthTokenUseCase(repository: authRepository)
            ),
            sessionRestorationUseCase: RestoreSessionUseCase(repository: authRepository)
        )
    }

    @MainActor
    static func restoreSession(
        sessionController: SessionController,
        restorationUseCase: any RestoreSessionUseCaseProtocol
    ) async {
        sessionController.beginRestoring()

        if let user = await restorationUseCase.execute() {
            sessionController.restoreSession(user)
        } else {
            sessionController.signOut()
        }
    }

    static func indexSearchSuggestionSeeds(searchEngine: AnySearchEngine) async throws {
        let seedDataSource = SearchSuggestionSeedDataSource()
        let indexer = SearchSuggestionSeedIndexer(
            seedDataSource: seedDataSource,
            searchEngine: searchEngine
        )

        try await indexer.indexSeeds()
    }
}
