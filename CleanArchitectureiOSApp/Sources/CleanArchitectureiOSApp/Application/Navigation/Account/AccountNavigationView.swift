//
//  AccountNavigationView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import SwiftUI
import Navigation

struct AccountNavigationView: View {
    private let container: DIContainer
    
    @ObservedObject private var sessionController: SessionController

    init(container: DIContainer, sessionController: SessionController) {
        self.container = container
        self._sessionController = ObservedObject(wrappedValue: sessionController)
    }

    var body: some View {
        Group {
            if #available(iOS 16.0, *) {
                AccountStackNavigationView(
                    container: container,
                    sessionController: sessionController
                )
            } else {
                AccountLegacyNavigationView(
                    container: container,
                    sessionController: sessionController
                )
            }
        }
    }
}

@available(iOS 16.0, *)
private struct AccountStackNavigationView: View {
    private let routeBuilder: AccountRouteBuilder
    private let accountNavigator: AccountNavigator
    
    @ObservedObject private var sessionController: SessionController
    
    @StateObject private var stack: StackNavigator<AccountRoute>

    init(container: DIContainer, sessionController: SessionController) {
        self._sessionController = ObservedObject(wrappedValue: sessionController)

        let stack = StackNavigator<AccountRoute>()
        self._stack = StateObject(wrappedValue: stack)

        self.routeBuilder = AccountRouteBuilder()
        self.accountNavigator = AccountNavigator(
            navigator: Navigator(stack)
        )
    }

    var body: some View {
        NavigationStack(
            path: Binding(
                get: { stack.path },
                set: { stack.replace(with: $0) }
            )
        ) {
            routeBuilder.makeRootView(
                loginState: sessionController.loginState,
                sessionController: sessionController,
                navigator: accountNavigator
            )
            .navigationDestination(for: AccountRoute.self) { route in
                routeBuilder.build(route, navigator: accountNavigator)
            }
        }
        .onChange(of: sessionController.loginState) { _ in
            stack.popToRoot()
        }
        .sheet(
            item: Binding<PresentationItem<AccountRoute>?>(
                get: {
                    guard let item = stack.presentationItem,
                          item.style != .fullScreenCover else {
                        return nil
                    }
                    return item
                },
                set: { newValue, _ in
                    if newValue == nil {
                        stack.dismiss()
                    }
                }
            )
        ) { item in
            routeBuilder.build(item.route, navigator: accountNavigator)
        }
        .fullScreenCover(
            item: Binding<PresentationItem<AccountRoute>?>(
                get: {
                    guard let item = stack.presentationItem,
                          item.style == .fullScreenCover else {
                        return nil
                    }
                    return item
                },
                set: { newValue, _ in
                    if newValue == nil {
                        stack.dismiss()
                    }
                }
            )
        ) { item in
            routeBuilder.build(item.route, navigator: accountNavigator)
        }
    }
}

private struct AccountLegacyNavigationView: View {
    private let routeBuilder: AccountRouteBuilder
    private let accountNavigator: AccountNavigator

    @ObservedObject private var sessionController: SessionController
    
    @StateObject private var state: AccountLegacyNavigationState

    init(container: DIContainer, sessionController: SessionController) {
        self._sessionController = ObservedObject(wrappedValue: sessionController)
        self.routeBuilder = AccountRouteBuilder()

        let navigationState = AccountLegacyNavigationState()
        self._state = StateObject(wrappedValue: navigationState)

        let legacy = LegacyNavigator<AccountRoute>(
            push: { route in
                navigationState.stack.append(route)
            },
            pop: {
                _ = navigationState.stack.popLast()
            },
            popToRoot: {
                navigationState.stack.removeAll()
            },
            replace: { routes in
                navigationState.stack = routes
            },
            popTo: { route in
                guard let index = navigationState.stack.lastIndex(of: route) else { return }
                navigationState.stack = Array(navigationState.stack.prefix(through: index))
            },
            present: { route, style in
                navigationState.presentationItem = PresentationItem(route: route, style: style)
            },
            dismiss: {
                navigationState.presentationItem = nil
            }
        )
        self.accountNavigator = AccountNavigator(navigator: Navigator(legacy))
    }

    var body: some View {
        NavigationView {
            ZStack {
                routeBuilder.makeRootView(
                    loginState: sessionController.loginState,
                    sessionController: sessionController,
                    navigator: accountNavigator
                )

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
                ) {
                    EmptyView()
                }
                .hidden()
            }
        }
        .onChange(of: sessionController.loginState) { _ in
            state.stack.removeAll()
        }
        .sheet(
            item: Binding<PresentationItem<AccountRoute>?>(
                get: {
                    guard let item = state.presentationItem,
                          item.style != .fullScreenCover else {
                        return nil
                    }
                    return item
                },
                set: { newValue, _ in
                    if newValue == nil {
                        state.presentationItem = nil
                    }
                }
            )
        ) { item in
            routeBuilder.build(item.route, navigator: accountNavigator)
        }
        .fullScreenCover(
            item: Binding<PresentationItem<AccountRoute>?>(
                get: {
                    guard let item = state.presentationItem,
                          item.style == .fullScreenCover else {
                        return nil
                    }
                    return item
                },
                set: { newValue, _ in
                    if newValue == nil {
                        state.presentationItem = nil
                    }
                }
            )
        ) { item in
            routeBuilder.build(item.route, navigator: accountNavigator)
        }
    }

    private func legacyDestination() -> AnyView {
        guard let route = state.stack.last else {
            return AnyView(EmptyView())
        }
        return routeBuilder.build(route, navigator: accountNavigator)
    }
}

private final class AccountLegacyNavigationState: ObservableObject {
    @Published var stack: [AccountRoute] = []
    @Published var presentationItem: PresentationItem<AccountRoute>?
}
