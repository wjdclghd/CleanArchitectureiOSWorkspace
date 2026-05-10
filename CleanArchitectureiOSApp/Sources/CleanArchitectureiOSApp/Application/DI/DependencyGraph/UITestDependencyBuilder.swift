//
//  UITestDependencyBuilder.swift
//  CleanArchitectureiOSApp
//
//  Created by Codex on 5/6/26.
//

import Foundation
import Networking
import Persistence
import SearchEngine
import AppDomain

enum UITestDependencyBuilder {
    @MainActor
    static func makeContainer(
        environment: AppEnvironment,
        scenario: UITestScenario
    ) async throws -> DIContainer {
        let coreDependencies = try await makeCoreDependencies()

        return DIContainer(
            appConfiguration: DebugAppConfiguration(),
            appEnvironment: environment,
            sessionController: SessionController(),
            networkClient: coreDependencies.networkClient,
            persistenceContainer: coreDependencies.persistenceContainer,
            searchEngineContainer: coreDependencies.searchEngineContainer,
            searchEngine: coreDependencies.searchEngine,
            searchAppStoreListUseCase: makeSearchAppStoreListUseCase(scenario: scenario),
            searchAppStoreDetailUseCase: makeSearchAppStoreDetailUseCase(scenario: scenario),
            searchHistoryUseCase: makeSearchHistoryUseCase(scenario: scenario),
            searchCandidateUseCase: makeSearchCandidateUseCase(scenario: scenario)
        )
    }
}

private extension UITestDependencyBuilder {
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

    static func makeSearchAppStoreListUseCase(
        scenario: UITestScenario
    ) -> AnySearchAppStoreListUseCase {
        switch scenario {
        case .searchSuccess:
            return AnySearchAppStoreListUseCase { _ in
                UITestSearchStubData.listItems
            }
        }
    }

    static func makeSearchAppStoreDetailUseCase(
        scenario: UITestScenario
    ) -> AnySearchAppStoreDetailUseCase {
        switch scenario {
        case .searchSuccess:
            return AnySearchAppStoreDetailUseCase { _ in
                UITestSearchStubData.detailItem
            }
        }
    }

    static func makeSearchHistoryUseCase(
        scenario: UITestScenario
    ) -> AnySearchHistoryUseCase {
        switch scenario {
        case .searchSuccess:
            return AnySearchHistoryUseCase(
                fetchRecentKeywords: {
                    [
                        SearchHistoryEntity(
                            id: "recent-kakao",
                            keyword: UITestSearchStubData.searchKeyword,
                            lastSearchedAt: Date(timeIntervalSince1970: 1_746_460_800)
                        )
                    ]
                },
                submitSearchKeyword: { keyword in
                    keyword.trimmingCharacters(in: .whitespacesAndNewlines)
                },
                saveRecentKeyword: { _ in },
                deleteRecentKeyword: { _ in },
                clearRecentKeywords: { }
            )
        }
    }

    static func makeSearchCandidateUseCase(
        scenario: UITestScenario
    ) -> AnySearchCandidateUseCase {
        switch scenario {
        case .searchSuccess:
            return AnySearchCandidateUseCase(
                fetchDefaultCandidates: {
                    UITestSearchStubData.candidates
                },
                fetchCandidates: { keyword in
                    UITestSearchStubData.candidates.filter {
                        $0.keyword.contains(keyword)
                    }
                }
            )
        }
    }
}
