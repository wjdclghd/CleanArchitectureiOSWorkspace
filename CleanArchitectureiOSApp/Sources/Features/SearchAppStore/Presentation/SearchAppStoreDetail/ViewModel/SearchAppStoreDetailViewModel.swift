//
//  SearchAppStoreViewModel.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/17/26.
//

import Foundation
import Combine

@MainActor
final class SearchAppStoreDetailViewModel: ObservableObject {
    @Published private(set) var searchAppStoreDetailEntity: SearchAppStoreDetailEntity?
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?

    private let useCase: SearchAppStoreDetailUseCaseProtocol
    private let trackId: Int
    private var fetchTask: Task<Void, Never>?

    init(
        useCase: SearchAppStoreDetailUseCaseProtocol,
        trackId: Int
    ) {
        self.useCase = useCase
        self.trackId = trackId

        fetchDetail()
    }

    deinit {
        fetchTask?.cancel()
    }

    func fetchDetail() {
        fetchTask?.cancel()

        fetchTask = Task { [weak self] in
            guard let self else { return }

            self.isLoading = true
            self.errorMessage = nil

            do {
                let entity = try await self.useCase.execute(trackId: self.trackId)

                if Task.isCancelled { return }

                self.searchAppStoreDetailEntity = entity
                self.isLoading = false
            } catch is CancellationError {
                self.isLoading = false
            } catch {
                if Task.isCancelled { return }

                self.searchAppStoreDetailEntity = nil
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
