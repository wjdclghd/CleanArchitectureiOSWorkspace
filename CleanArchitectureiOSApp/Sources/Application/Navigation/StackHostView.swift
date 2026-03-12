//
//  StackHostView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/6/26.
//

import Foundation
import SwiftUI
import Navigation

@available(iOS 16.0, *)
struct StackHostView: View {
    private let container: DIContainer
    private let coordinator: NavigationCoordinator
    
    private let onLogout: () -> Void
    
    @StateObject private var stack: StackNavigator<NavigationRoute>
    
    init(container: DIContainer, onLogout: @escaping () -> Void) {
        self.container = container
        
        let stack = StackNavigator<NavigationRoute>()
        self._stack = StateObject(wrappedValue: stack)
        
        let navigator = Navigator(stack)
        self.coordinator = NavigationCoordinator(container: container, navigator: navigator)
        
        self.onLogout = onLogout
    }
    
    var body: some View {
        NavigationStack(path: $stack.path) {
            HomeSceneFactory.homeView(coordinator: coordinator, onLogout: onLogout)
                .navigationDestination(for: NavigationRoute.self) { route in
                    coordinator.build(route: route)
                }
        }
        .sheet(
            isPresented: Binding(
                get: {
                    stack.presented != nil
                },
                set: {
                    if !$0 {
                        stack.dismiss()
                    }
                }
            )
        ) {
            if let route = stack.presented {
                coordinator.build(route: route)
            }
        }
    }
}
