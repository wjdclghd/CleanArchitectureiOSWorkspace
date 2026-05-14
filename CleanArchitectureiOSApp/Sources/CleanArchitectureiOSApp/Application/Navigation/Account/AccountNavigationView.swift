//
//  AccountNavigationView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import SwiftUI
import Navigation

/// iOS 버전에 따라 NavigationStack 또는 NavigationView를 선택하여 Account 화면 흐름을 구성합니다.
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
    private let container: DIContainer
    private let routeBuilder: AccountRouteBuilder
    private let accountNavigator: AccountNavigator

    @ObservedObject private var sessionController: SessionController

    @StateObject private var stack: StackNavigator<AccountRoute>

    init(container: DIContainer, sessionController: SessionController) {
        self.container = container
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
                container: container,
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
    private let container: DIContainer
    private let routeBuilder: AccountRouteBuilder

    @ObservedObject private var sessionController: SessionController

    @StateObject private var controller: AccountLegacyNavigationController

    init(container: DIContainer, sessionController: SessionController) {
        self.container = container
        self._sessionController = ObservedObject(wrappedValue: sessionController)
        self.routeBuilder = AccountRouteBuilder()
        self._controller = StateObject(wrappedValue: AccountLegacyNavigationController())
    }

    var body: some View {
        let navigator = AccountNavigator(navigator: controller.navigator)

        NavigationView {
            ZStack {
                routeBuilder.makeRootView(
                    loginState: sessionController.loginState,
                    container: container,
                    sessionController: sessionController,
                    navigator: navigator
                )

                NavigationLink(
                    destination: legacyDestination(navigator: navigator),
                    isActive: Binding(
                        get: { !controller.stack.isEmpty },
                        set: { isActive in
                            if !isActive {
                                _ = controller.stack.popLast()
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
            controller.stack.removeAll()
        }
        .sheet(
            item: Binding<PresentationItem<AccountRoute>?>(
                get: {
                    guard let item = controller.presentationItem,
                          item.style != .fullScreenCover else {
                        return nil
                    }
                    return item
                },
                set: { newValue, _ in
                    if newValue == nil {
                        controller.presentationItem = nil
                    }
                }
            )
        ) { item in
            routeBuilder.build(item.route, navigator: navigator)
        }
        .fullScreenCover(
            item: Binding<PresentationItem<AccountRoute>?>(
                get: {
                    guard let item = controller.presentationItem,
                          item.style == .fullScreenCover else {
                        return nil
                    }
                    return item
                },
                set: { newValue, _ in
                    if newValue == nil {
                        controller.presentationItem = nil
                    }
                }
            )
        ) { item in
            routeBuilder.build(item.route, navigator: navigator)
        }
    }

    private func legacyDestination(navigator: AccountNavigator) -> AnyView {
        guard let route = controller.stack.last else {
            return AnyView(EmptyView())
        }
        return routeBuilder.build(route, navigator: navigator)
    }
}

@MainActor
private final class AccountLegacyNavigationController: ObservableObject {
    @Published var stack: [AccountRoute] = []
    @Published var presentationItem: PresentationItem<AccountRoute>?

    private(set) lazy var navigator: Navigator<AccountRoute> = {
        let legacy = LegacyNavigator<AccountRoute>(
            push: { [weak self] route in
                self?.stack.append(route)
            },
            pop: { [weak self] in
                _ = self?.stack.popLast()
            },
            popToRoot: { [weak self] in
                self?.stack.removeAll()
            },
            replace: { [weak self] routes in
                self?.stack = routes
            },
            popTo: { [weak self] route in
                guard let self,
                      let index = self.stack.lastIndex(of: route) else { return }
                self.stack = Array(self.stack.prefix(through: index))
            },
            present: { [weak self] route, style in
                self?.presentationItem = PresentationItem(route: route, style: style)
            },
            dismiss: { [weak self] in
                self?.presentationItem = nil
            }
        )
        return Navigator(legacy)
    }()
}
