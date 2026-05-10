//
//  ProductionDependencyBuilder.swift
//  CleanArchitectureiOSApp
//
//  Created by Codex on 5/6/26.
//

import Foundation
import Networking
import Persistence
import SearchEngine
import AppDomain
import AppData

enum ProductionDependencyBuilder {
    @MainActor
    static func makeContainer(environment: AppEnvironment) async throws -> DIContainer {
        let coreDependencies = try await makeCoreDependencies()
        let searchAppStoreRemoteDataSource = SearchAppStoreDataSource(
            networkClient: coreDependencies.networkClient
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

        let container = DIContainer(
            appConfiguration: DebugAppConfiguration(),
            appEnvironment: environment,
            sessionController: SessionController(),
            networkClient: coreDependencies.networkClient,
            persistenceContainer: coreDependencies.persistenceContainer,
            searchEngineContainer: coreDependencies.searchEngineContainer,
            searchEngine: coreDependencies.searchEngine,
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

        return container
    }
}

private extension ProductionDependencyBuilder {
    struct CoreDependencies {
        let networkClient: URLSessionNetworkClient
        let persistenceContainer: PersistenceContainer
        let searchEngineContainer: SearchEngineContainer
        let searchEngine: AnySearchEngine
    }

    static func makeCoreDependencies() async throws -> CoreDependencies {
        let networkRequestBuilder = NetworkRequestBuilder()
        let networkClient = URLSessionNetworkClient(
            requestBuilder: networkRequestBuilder
        )
        let persistenceContainer = try await PersistenceContainer.makeDefault()
        let searchEngineContainer = try SearchEngineContainer.makeDefault()
        let searchEngine = AnySearchEngine(searchEngineContainer.makeSearchEngine())

        return CoreDependencies(
            networkClient: networkClient,
            persistenceContainer: persistenceContainer,
            searchEngineContainer: searchEngineContainer,
            searchEngine: searchEngine
        )
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
