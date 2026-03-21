//
//  SearchAppStoreListViewModel.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/17/26.
//

import Foundation
import SwiftUI

import Combine

final class SearchAppStoreListViewModel: ObservableObject {
    @Published private(set) var searchAppStoreListEntity: [SearchAppStoreListEntity] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?

    private let useCase: SearchAppStoreListUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    init(useCase: SearchAppStoreListUseCaseProtocol, searchKeyword: String) {
        self.useCase = useCase
        
        fetchResults(searchKeyword: searchKeyword)
    }

    func fetchResults(searchKeyword: String) {
        isLoading = true
        errorMessage = nil
        
        useCase.execute(searchKeyword: searchKeyword)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else {
                    return
                }
                
                self.isLoading = false
                
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                    self.searchAppStoreListEntity = []
                }
            } receiveValue: { [weak self] entity in
                self?.searchAppStoreListEntity = entity
            }
            .store(in: &cancellables)
    }
}
