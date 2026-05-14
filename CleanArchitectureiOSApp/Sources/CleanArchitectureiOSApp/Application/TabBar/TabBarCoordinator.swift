//
//  TabBarCoordinator.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import Foundation
import Combine
import Navigation

@MainActor
final class TabBarCoordinator: ObservableObject, TabNavigatorProtocol {
    @Published private(set) var selectedTab: TabBarItem = .home

    var loginState: LoginState {
        sessionController.loginState
    }

    private let sessionController: SessionController
    private var cancellables: Set<AnyCancellable> = []

    init(
        sessionController: SessionController,
        initialSelectedTab: TabBarItem = .home
    ) {
        self.sessionController = sessionController
        self.selectedTab = initialSelectedTab

        sessionController.$sessionState
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }

    func select(_ tab: TabBarItem) {
        if selectedTab == tab {
            return
        }
        
        selectedTab = tab
    }
}
