//
//  HomeNavigationView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import SwiftUI
import Navigation

/// iOS 버전에 따라 NavigationStack 또는 NavigationView를 선택하여 Home 화면 흐름을 구성합니다.
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

    @StateObject private var controller: HomeLegacyNavigationController

    init(container: DIContainer) {
        self.routeBuilder = HomeRouteBuilder(container: container)
        self._controller = StateObject(wrappedValue: HomeLegacyNavigationController())
    }

    var body: some View {
        let navigator = HomeNavigator(navigator: controller.navigator)

        NavigationView {
            ZStack {
                routeBuilder.makeRootView(navigator: navigator)

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
        .sheet(
            item: Binding<PresentationItem<HomeRoute>?>(
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
            item: Binding<PresentationItem<HomeRoute>?>(
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

    private func legacyDestination(navigator: HomeNavigator) -> AnyView {
        guard let route = controller.stack.last else {
            return AnyView(EmptyView())
        }
        return routeBuilder.build(route, navigator: navigator)
    }
}

@MainActor
private final class HomeLegacyNavigationController: ObservableObject {
    @Published var stack: [HomeRoute] = []
    @Published var presentationItem: PresentationItem<HomeRoute>?

    private(set) lazy var navigator: Navigator<HomeRoute> = {
        let legacy = LegacyNavigator<HomeRoute>(
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
