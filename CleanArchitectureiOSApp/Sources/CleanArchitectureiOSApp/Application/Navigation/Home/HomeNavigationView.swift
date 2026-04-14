//
//  HomeNavigationView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import SwiftUI
import Navigation

struct HomeNavigationView: View {
    private let container: DIContainer

    init(container: DIContainer) {
        self.container = container
    }

    var body: some View {
        Group {
            if #available(iOS 16.0, *) {
                HomeStackNavigationView(container: container)
            } else {
                HomeLegacyNavigationView(container: container)
            }
        }
    }
}

@available(iOS 16.0, *)
private struct HomeStackNavigationView: View {
    private let routeBuilder: HomeRouteBuilder
    private let homeNavigator: HomeNavigator

    @StateObject private var stack: StackNavigator<HomeRoute>

    init(container: DIContainer) {
        let stack = StackNavigator<HomeRoute>()
        self._stack = StateObject(wrappedValue: stack)

        self.routeBuilder = HomeRouteBuilder(container: container)
        self.homeNavigator = HomeNavigator(
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
            routeBuilder.makeRootView(navigator: homeNavigator)
                .navigationDestination(for: HomeRoute.self) { route in
                    routeBuilder.build(route, navigator: homeNavigator)
                }
        }
        .sheet(
            item: Binding<PresentationItem<HomeRoute>?>(
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
            routeBuilder.build(item.route, navigator: homeNavigator)
        }
        .fullScreenCover(
            item: Binding<PresentationItem<HomeRoute>?>(
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
            routeBuilder.build(item.route, navigator: homeNavigator)
        }
    }
}

private struct HomeLegacyNavigationView: View {
    private let routeBuilder: HomeRouteBuilder
    private let homeNavigator: HomeNavigator

    @StateObject private var state: HomeLegacyNavigationState

    init(container: DIContainer) {
        self.routeBuilder = HomeRouteBuilder(container: container)

        let navigationState = HomeLegacyNavigationState()
        self._state = StateObject(wrappedValue: navigationState)

        let legacy = LegacyNavigator<HomeRoute>(
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
        self.homeNavigator = HomeNavigator(navigator: Navigator(legacy))
    }

    var body: some View {
        NavigationView {
            ZStack {
                routeBuilder.makeRootView(navigator: homeNavigator)

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
        .sheet(
            item: Binding<PresentationItem<HomeRoute>?>(
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
            routeBuilder.build(item.route, navigator: homeNavigator)
        }
        .fullScreenCover(
            item: Binding<PresentationItem<HomeRoute>?>(
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
            routeBuilder.build(item.route, navigator: homeNavigator)
        }
    }

    private func legacyDestination() -> AnyView {
        guard let route = state.stack.last else {
            return AnyView(EmptyView())
        }
        return routeBuilder.build(route, navigator: homeNavigator)
    }
}

private final class HomeLegacyNavigationState: ObservableObject {
    @Published var stack: [HomeRoute] = []
    @Published var presentationItem: PresentationItem<HomeRoute>?
}
