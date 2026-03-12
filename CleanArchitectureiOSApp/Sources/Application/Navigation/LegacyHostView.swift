//
//  LegacyHostView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/6/26.
//

import Foundation
import SwiftUI
import Navigation

struct LegacyHostView: View {
    private let container: DIContainer
    private let coordinator: NavigationCoordinator

    @StateObject private var state: LegacyNavigationState<NavigationRoute>
    
    private let onLogout: () -> Void
    
    init(container: DIContainer, onLogout: @escaping () -> Void) {
        self.container = container
        
        let navigationState = LegacyNavigationState<NavigationRoute>()
        self._state = StateObject(wrappedValue: navigationState)
        
        let legacy = LegacyNavigator<NavigationRoute>(
            push: { route in
                navigationState.stack.append(route)
            },
            pop: {
                _ = navigationState.stack.popLast()
            },
            popToRoot: {
                navigationState.stack.removeAll()
            },
            present: { route in
                navigationState.presented = route
            },
            dismiss: {
                navigationState.presented = nil
            }
        )
        
        let navigator = Navigator(legacy)
        self.coordinator = NavigationCoordinator(container: container, navigator: navigator)
        
        self.onLogout = onLogout
    }

    var body: some View {
        NavigationView {
            ZStack {
                HomeSceneFactory.homeView(coordinator: coordinator, onLogout: onLogout)

                NavigationLink(
                    destination: legacyDestination(),
                    isActive: Binding(
                        get: { !state.stack.isEmpty },
                        set: { isActive in
                            if !isActive {
                                _ = state.stack.popLast()
                            }
                        }
                    )
                ) { EmptyView() }
                .hidden()
            }
        }
        .sheet(
            isPresented: Binding(
                get: {
                    state.presented != nil
                },
                set: {
                    if !$0 {
                        state.presented = nil
                    }
                }
            )
        ) {
            if let route = state.presented {
                coordinator.build(route: route)
            }
        }
    }
    
    private func legacyDestination() -> AnyView {
        guard let route = state.stack.last else {
            return AnyView(
                HomeSceneFactory.homeView(
                    coordinator: coordinator,
                    onLogout: onLogout
                )
            )
        }

        return coordinator.build(route: route)
    }
}
