//
//  DIContainer.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import Foundation
import Networking
import Persistence
import SearchEngine
import AppDomain
import AppData

/// App 레이어의 composition root입니다.
struct DIContainer {
    let appConfiguration: DebugAppConfiguration
    let appEnvironment: AppEnvironment
    let sessionController: SessionController
    let networkClient: URLSessionNetworkClient
    let persistenceContainer: PersistenceContainer
    let searchEngineContainer: SearchEngineContainer
    let searchEngine: AnySearchEngine
    let searchAppStoreListUseCase: AnySearchAppStoreListUseCase
    let searchAppStoreDetailUseCase: AnySearchAppStoreDetailUseCase
    let searchHistoryUseCase: AnySearchHistoryUseCase
    let searchCandidateUseCase: AnySearchCandidateUseCase

    typealias SearchAppStoreRemoteDataSource = SearchAppStoreDataSource<URLSessionNetworkClient>
    typealias SearchAppStoreListRepositoryType = SearchAppStoreListRepository<SearchAppStoreRemoteDataSource>
    typealias SearchAppStoreDetailRepositoryType = SearchAppStoreDetailRepository<SearchAppStoreRemoteDataSource>
    typealias SearchAppStoreListUseCaseType = AnySearchAppStoreListUseCase
    typealias SearchAppStoreDetailUseCaseType = AnySearchAppStoreDetailUseCase

    typealias SearchHistoryDataSourceType = SearchHistoryDataSource<AnySearchHistoryStore>
    typealias SearchHistoryRepositoryType = SearchHistoryRepository<SearchHistoryDataSourceType>
    typealias SearchHistoryUseCaseType = AnySearchHistoryUseCase

    typealias SearchSuggestionDataSourceType = SearchSuggestionDataSource<AnySearchEngine>
    typealias SearchSuggestionRepositoryType = SearchSuggestionRepository<SearchSuggestionDataSourceType>
    typealias SearchCandidateUseCaseType = AnySearchCandidateUseCase
}

extension DIContainer {
    /// 기본 App 의존성 그래프를 생성합니다.
    @MainActor
    static func makeDefault() async throws -> DIContainer {
        let environment = AppEnvironment.current()

        return try await AppDependencyGraphBuilder.makeContainer(
            environment: environment
        )
    }

    /// SearchAppStore 목록 조회 유스케이스를 생성합니다.
    func makeSearchAppStoreListUseCase() -> SearchAppStoreListUseCaseType {
        searchAppStoreListUseCase
    }

    /// SearchAppStore 상세 조회 유스케이스를 생성합니다.
    func makeSearchAppStoreDetailUseCase() -> SearchAppStoreDetailUseCaseType {
        searchAppStoreDetailUseCase
    }

    /// 최근 검색어 유스케이스를 생성합니다.
    func makeSearchHistoryUseCase() -> SearchHistoryUseCaseType {
        searchHistoryUseCase
    }

    /// 검색 후보 구성 유스케이스를 생성합니다.
    func makeSearchCandidateUseCase() -> SearchCandidateUseCaseType {
        searchCandidateUseCase
    }
}

/// SearchEngine 공개 계약을 App Target 조립에서 보관하기 위한 type eraser입니다.
struct AnySearchEngine: SearchEngineProtocol {
    private let indexDocument: (SearchDocument) async throws -> Void
    private let indexDocuments: ([SearchDocument]) async throws -> Void
    private let deleteDocumentByID: (String) async throws -> Void
    private let searchQuery: (SearchQuery) async throws -> [SearchHit]
    private let suggestQuery: (SearchSuggestionQuery) async throws -> [SearchSuggestion]
    private let rebuildIndex: () async throws -> Void

    init<Engine: SearchEngineProtocol>(_ engine: Engine) {
        self.indexDocument = { document in
            try await engine.index(document)
        }
        self.indexDocuments = { documents in
            try await engine.index(documents)
        }
        self.deleteDocumentByID = { id in
            try await engine.deleteDocument(id: id)
        }
        self.searchQuery = { query in
            try await engine.search(query)
        }
        self.suggestQuery = { query in
            try await engine.suggest(query)
        }
        self.rebuildIndex = {
            try await engine.rebuild()
        }
    }

    func index(_ document: SearchDocument) async throws {
        try await indexDocument(document)
    }

    func index(_ documents: [SearchDocument]) async throws {
        try await indexDocuments(documents)
    }

    func deleteDocument(id: String) async throws {
        try await deleteDocumentByID(id)
    }

    func search(_ query: SearchQuery) async throws -> [SearchHit] {
        try await searchQuery(query)
    }

    func suggest(_ query: SearchSuggestionQuery) async throws -> [SearchSuggestion] {
        try await suggestQuery(query)
    }

    func rebuild() async throws {
        try await rebuildIndex()
    }
}

/// SearchHistoryStore 공개 계약을 AppData 제네릭 조립에 전달하기 위한 type eraser입니다.
struct AnySearchHistoryStore: SearchHistoryStoreProtocol {
    private let fetchAllRecords: () async throws -> [SearchHistoryRecord]
    private let fetchMatchingRecords: (String) async throws -> [SearchHistoryRecord]
    private let saveRecord: (SearchHistoryRecord) async throws -> Void
    private let deleteRecord: (String) async throws -> Void
    private let deleteAllRecords: () async throws -> Void

    init(_ store: any SearchHistoryStoreProtocol) {
        self.fetchAllRecords = {
            try await store.fetchAll()
        }
        self.fetchMatchingRecords = { keyword in
            try await store.fetchRecords(matching: keyword)
        }
        self.saveRecord = { record in
            try await store.save(record)
        }
        self.deleteRecord = { keyword in
            try await store.delete(keyword: keyword)
        }
        self.deleteAllRecords = {
            try await store.deleteAll()
        }
    }

    func fetchAll() async throws -> [SearchHistoryRecord] {
        try await fetchAllRecords()
    }

    func fetchRecords(matching keyword: String) async throws -> [SearchHistoryRecord] {
        try await fetchMatchingRecords(keyword)
    }

    func save(_ record: SearchHistoryRecord) async throws {
        try await saveRecord(record)
    }

    func delete(keyword: String) async throws {
        try await deleteRecord(keyword)
    }

    func deleteAll() async throws {
        try await deleteAllRecords()
    }
}
