//
//  SearchAppStoreListViewModel.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/17/26.
//

import Foundation
import Combine

@MainActor
final class SearchAppStoreListViewModel: ObservableObject {
    @Published private(set) var searchAppStoreListEntity: [SearchAppStoreListEntity] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?

    private let useCase: SearchAppStoreListUseCaseProtocol
    private var fetchTask: Task<Void, Never>?

    init(useCase: SearchAppStoreListUseCaseProtocol, searchKeyword: String) {
        self.useCase = useCase
        fetchResults(searchKeyword: searchKeyword)
    }

    deinit {
        fetchTask?.cancel()
    }

    func fetchResults(searchKeyword: String) {
        fetchTask?.cancel()

        fetchTask = Task { [weak self] in
            guard let self else { return }

            self.isLoading = true
            self.errorMessage = nil

            do {
                let entity = try await self.useCase.execute(searchKeyword: searchKeyword)

                if Task.isCancelled { return }

                self.searchAppStoreListEntity = entity
                self.isLoading = false
            } catch is CancellationError {
                self.isLoading = false
            } catch {
                if Task.isCancelled { return }

                self.searchAppStoreListEntity = []
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
