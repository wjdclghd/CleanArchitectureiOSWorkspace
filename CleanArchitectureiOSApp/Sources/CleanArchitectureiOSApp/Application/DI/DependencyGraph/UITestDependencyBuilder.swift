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
            loginUseCase: makeLoginUseCase(scenario: scenario),
            sessionLogoutUseCase: makeSessionLogoutUseCase(scenario: scenario),
            refreshAuthTokenUseCase: makeRefreshAuthTokenUseCase(scenario: scenario),
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
        case .searchSuccess, .loginSuccess:
            return AnySearchAppStoreListUseCase { _ in
                UITestSearchStubData.listItems
            }
        }
    }

    static func makeSearchAppStoreDetailUseCase(
        scenario: UITestScenario
    ) -> AnySearchAppStoreDetailUseCase {
        switch scenario {
        case .searchSuccess, .loginSuccess:
            return AnySearchAppStoreDetailUseCase { _ in
                UITestSearchStubData.detailItem
            }
        }
    }

    static func makeSearchHistoryUseCase(
        scenario: UITestScenario
    ) -> AnySearchHistoryUseCase {
        switch scenario {
        case .searchSuccess, .loginSuccess:
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
        case .searchSuccess, .loginSuccess:
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

    static func makeLoginUseCase(
        scenario: UITestScenario
    ) -> AnyLoginUseCase {
        switch scenario {
        case .searchSuccess, .loginSuccess:
            return AnyLoginUseCase { email, _ in
                AuthSessionEntity(
                    token: AuthTokenEntity(
                        accessToken: "ui-test-access-token",
                        refreshToken: "ui-test-refresh-token",
                        accessTokenExpiresAt: Date(timeIntervalSince1970: 1_800_000_000),
                        refreshTokenExpiresAt: Date(timeIntervalSince1970: 1_900_000_000)
                    ),
                    user: AuthenticatedUserEntity(
                        userId: 1,
                        email: email,
                        nickname: "UITest",
                        role: "USER",
                        status: "ACTIVE"
                    )
                )
            }
        }
    }

    static func makeSessionLogoutUseCase(
        scenario: UITestScenario
    ) -> AnySessionLogoutUseCase {
        switch scenario {
        case .searchSuccess, .loginSuccess:
            return AnySessionLogoutUseCase(execute: { })
        }
    }

    static func makeRefreshAuthTokenUseCase(
        scenario: UITestScenario
    ) -> AnyRefreshAuthTokenUseCase {
        switch scenario {
        case .searchSuccess, .loginSuccess:
            return AnyRefreshAuthTokenUseCase { _ in
                AuthSessionEntity(
                    token: AuthTokenEntity(
                        accessToken: "ui-test-refreshed-access-token",
                        refreshToken: "ui-test-refreshed-refresh-token",
                        accessTokenExpiresAt: Date(timeIntervalSince1970: 1_800_000_000),
                        refreshTokenExpiresAt: Date(timeIntervalSince1970: 1_900_000_000)
                    ),
                    user: AuthenticatedUserEntity(
                        userId: 1,
                        email: "uitest@example.com",
                        nickname: "UITest",
                        role: "USER",
                        status: "ACTIVE"
                    )
                )
            }
        }
    }
}
