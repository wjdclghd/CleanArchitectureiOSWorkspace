//
//  LegacyHostView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/6/26.
//

import Foundation
import SwiftUI
import Navigation

//struct LegacyHostView: View {
//    private let container: DIContainer
//
//    @StateObject private var state = LegacyNavigationState<AppRoute>()
//    
//    init(container: DIContainer) {
//        self.container = container
//    }
//
//    var body: some View {
//        let legacy = LegacyNavigator<AppRoute>(
//            push: { route in state.stack.append(route) },
//            pop: { _ = state.stack.popLast() },
//            popToRoot: { state.stack.removeAll() },
//            present: { route in state.presented = route },
//            dismiss: { state.presented = nil }
//        )
//
//        let navigator = Navigator(legacy)
//        let coordinator = NavigationCoordinator(container: container, navigator: navigator)
//
//        NavigationView {
//            ZStack {
//                coordinator.rootView()
//
//                NavigationLink(
//                    destination: legacyDestination(coordinator: coordinator),
//                    isActive: Binding(
//                        get: { !state.stack.isEmpty },
//                        set: { isActive in
//                            if !isActive {
//                                _ = state.stack.popLast()
//                            }
//                        }
//                    )
//                ) { EmptyView() }
//                .hidden()
//            }
//        }
//        .sheet(isPresented: Binding(
//            get: { state.presented != nil },
//            set: { if !$0 { state.presented = nil } }
//        )) {
//            if let route = state.presented {
//                coordinator.build(route: route)
//            }
//        }
//    }
//
//    private func legacyDestination(coordinator: NavigationCoordinator) -> AnyView {
//        guard let route = state.stack.last else {
//            return coordinator.rootView()
//        }
//        
//        return coordinator.build(route: route)
//    }
//}
