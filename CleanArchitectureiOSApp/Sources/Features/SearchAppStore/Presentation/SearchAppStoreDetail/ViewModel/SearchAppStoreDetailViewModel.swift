//
//  SearchAppStoreViewModel.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/17/26.
//

import Foundation
import Combine

final class SearchAppStoreDetailViewModel: ObservableObject {
    @Published private(set) var searchAppStoreDetailEntity: SearchAppStoreDetailEntity?
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?

    private let useCase: SearchAppStoreDetailUseCaseProtocol
    private let trackId: Int
    private var cancellables = Set<AnyCancellable>()

    init(
        useCase: SearchAppStoreDetailUseCaseProtocol,
        trackId: Int
    ) {
        self.useCase = useCase
        self.trackId = trackId
        
        fetchDetail()
    }

    func fetchDetail() {
        isLoading = true
        errorMessage = nil

        useCase.execute(trackId: trackId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else {
                    return
                }
                
                self.isLoading = false

                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                    self.searchAppStoreDetailEntity = nil
                }
            } receiveValue: { [weak self] entity in
                self?.searchAppStoreDetailEntity = entity
            }
            .store(in: &cancellables)
    }
}
