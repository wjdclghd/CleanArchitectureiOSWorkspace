//
//  AnyUseCases.swift
//  CleanArchitectureiOSApp
//
//  Created by Codex on 5/6/26.
//

import Foundation
import AppDomain

struct AnyLoginUseCase: LoginUseCaseProtocol {
    private let executeHandler: @Sendable (String, String) async throws -> AuthSessionEntity

    init<UseCase: LoginUseCaseProtocol>(_ useCase: UseCase) {
        self.executeHandler = { email, password in
            try await useCase.execute(email: email, password: password)
        }
    }

    init(
        execute: @escaping @Sendable (String, String) async throws -> AuthSessionEntity
    ) {
        self.executeHandler = execute
    }

    func execute(
        email: String,
        password: String
    ) async throws -> AuthSessionEntity {
        try await executeHandler(email, password)
    }
}

struct AnySessionLogoutUseCase: LogoutSessionUseCaseProtocol {
    private let executeHandler: @Sendable () async throws -> Void

    init<UseCase: LogoutSessionUseCaseProtocol>(_ useCase: UseCase) {
        self.executeHandler = { try await useCase.execute() }
    }

    init(execute: @escaping @Sendable () async throws -> Void) {
        self.executeHandler = execute
    }

    func execute() async throws {
        try await executeHandler()
    }
}

struct AnyRefreshAuthTokenUseCase: RefreshAuthTokenUseCaseProtocol {
    private let executeHandler: @Sendable (String) async throws -> AuthSessionEntity

    init<UseCase: RefreshAuthTokenUseCaseProtocol>(_ useCase: UseCase) {
        self.executeHandler = { refreshToken in
            try await useCase.execute(refreshToken: refreshToken)
        }
    }

    init(
        execute: @escaping @Sendable (String) async throws -> AuthSessionEntity
    ) {
        self.executeHandler = execute
    }

    func execute(refreshToken: String) async throws -> AuthSessionEntity {
        try await executeHandler(refreshToken)
    }
}

struct AnySearchAppStoreListUseCase: SearchAppStoreListUseCaseProtocol {
    private let executeHandler: @Sendable (String) async throws -> [SearchAppStoreListEntity]

    init<UseCase: SearchAppStoreListUseCaseProtocol>(_ useCase: UseCase) {
        self.executeHandler = { searchKeyword in
            try await useCase.execute(searchKeyword: searchKeyword)
        }
    }

    init(
        execute: @escaping @Sendable (String) async throws -> [SearchAppStoreListEntity]
    ) {
        self.executeHandler = execute
    }

    func execute(searchKeyword: String) async throws -> [SearchAppStoreListEntity] {
        try await executeHandler(searchKeyword)
    }
}

struct AnySearchAppStoreDetailUseCase: SearchAppStoreDetailUseCaseProtocol {
    private let executeHandler: @Sendable (Int) async throws -> SearchAppStoreDetailEntity

    init<UseCase: SearchAppStoreDetailUseCaseProtocol>(_ useCase: UseCase) {
        self.executeHandler = { trackId in
            try await useCase.execute(trackId: trackId)
        }
    }

    init(
        execute: @escaping @Sendable (Int) async throws -> SearchAppStoreDetailEntity
    ) {
        self.executeHandler = execute
    }

    func execute(trackId: Int) async throws -> SearchAppStoreDetailEntity {
        try await executeHandler(trackId)
    }
}

struct AnySearchHistoryUseCase: SearchHistoryUseCaseProtocol {
    private let fetchRecentKeywordsHandler: @Sendable () async throws -> [SearchHistoryEntity]
    private let submitSearchKeywordHandler: @Sendable (String) async throws -> String
    private let saveRecentKeywordHandler: @Sendable (String) async throws -> Void
    private let deleteRecentKeywordHandler: @Sendable (String) async throws -> Void
    private let clearRecentKeywordsHandler: @Sendable () async throws -> Void

    init<UseCase: SearchHistoryUseCaseProtocol>(_ useCase: UseCase) {
        self.fetchRecentKeywordsHandler = {
            try await useCase.fetchRecentKeywords()
        }
        self.submitSearchKeywordHandler = { keyword in
            try await useCase.submitSearchKeyword(keyword)
        }
        self.saveRecentKeywordHandler = { keyword in
            try await useCase.saveRecentKeyword(keyword)
        }
        self.deleteRecentKeywordHandler = { id in
            try await useCase.deleteRecentKeyword(id: id)
        }
        self.clearRecentKeywordsHandler = {
            try await useCase.clearRecentKeywords()
        }
    }

    init(
        fetchRecentKeywords: @escaping @Sendable () async throws -> [SearchHistoryEntity],
        submitSearchKeyword: @escaping @Sendable (String) async throws -> String,
        saveRecentKeyword: @escaping @Sendable (String) async throws -> Void,
        deleteRecentKeyword: @escaping @Sendable (String) async throws -> Void,
        clearRecentKeywords: @escaping @Sendable () async throws -> Void
    ) {
        self.fetchRecentKeywordsHandler = fetchRecentKeywords
        self.submitSearchKeywordHandler = submitSearchKeyword
        self.saveRecentKeywordHandler = saveRecentKeyword
        self.deleteRecentKeywordHandler = deleteRecentKeyword
        self.clearRecentKeywordsHandler = clearRecentKeywords
    }

    func fetchRecentKeywords() async throws -> [SearchHistoryEntity] {
        try await fetchRecentKeywordsHandler()
    }

    func submitSearchKeyword(_ keyword: String) async throws -> String {
        try await submitSearchKeywordHandler(keyword)
    }

    func saveRecentKeyword(_ keyword: String) async throws {
        try await saveRecentKeywordHandler(keyword)
    }

    func deleteRecentKeyword(id: String) async throws {
        try await deleteRecentKeywordHandler(id)
    }

    func clearRecentKeywords() async throws {
        try await clearRecentKeywordsHandler()
    }
}

struct AnySearchCandidateUseCase: SearchCandidateUseCaseProtocol {
    private let fetchDefaultCandidatesHandler: @Sendable () async throws -> [SearchCandidateEntity]
    private let fetchCandidatesHandler: @Sendable (String) async throws -> [SearchCandidateEntity]

    init<UseCase: SearchCandidateUseCaseProtocol>(_ useCase: UseCase) {
        self.fetchDefaultCandidatesHandler = {
            try await useCase.fetchDefaultCandidates()
        }
        self.fetchCandidatesHandler = { keyword in
            try await useCase.fetchCandidates(keyword: keyword)
        }
    }

    init(
        fetchDefaultCandidates: @escaping @Sendable () async throws -> [SearchCandidateEntity],
        fetchCandidates: @escaping @Sendable (String) async throws -> [SearchCandidateEntity]
    ) {
        self.fetchDefaultCandidatesHandler = fetchDefaultCandidates
        self.fetchCandidatesHandler = fetchCandidates
    }

    func fetchDefaultCandidates() async throws -> [SearchCandidateEntity] {
        try await fetchDefaultCandidatesHandler()
    }

    func fetchCandidates(keyword: String) async throws -> [SearchCandidateEntity] {
        try await fetchCandidatesHandler(keyword)
    }
}
