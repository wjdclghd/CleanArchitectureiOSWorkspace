//
//  TabBarView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import SwiftUI
import DesignSystem

struct TabBarView: View {
    private let container: DIContainer
    private let tabBarStylePolicy = DSTabBarStylePolicy.standard

    @StateObject private var coordinator: TabBarCoordinator

    init(container: DIContainer) {
        self.container = container
        self._coordinator = StateObject(
            wrappedValue: TabBarCoordinator(
                sessionController: container.sessionController
            )
        )
    }

    var body: some View {
        let items = TabBarItemBuilder.makeItems(loginState: coordinator.loginState)

        TabView(
            selection: Binding(
                get: { coordinator.selectedTab },
                set: { coordinator.select($0) }
            )
        ) {
            ForEach(items, id: \.item) { descriptor in
                tabRoot(for: descriptor.item, title: descriptor.title)
                    .tabItem {
                        Label {
                            Text(descriptor.title)
                        } icon: {
                            Image(systemName: systemImageName(for: descriptor))
                                .font(.system(size: tabBarStylePolicy.iconSize))
                                .frame(
                                    width: tabBarStylePolicy.iconSize,
                                    height: tabBarStylePolicy.iconSize
                                )
                        }
                    }
                    .tag(descriptor.item)
            }
        }
    }

    @ViewBuilder
    private func tabRoot(for item: TabBarItem, title: String) -> some View {
        switch item {
        case .home:
            HomeTabRootView(container: container)
        case .account:
            AccountTabRootView(
                container: container,
                sessionController: container.sessionController
            )
        case .tabbar2, .tabbar4, .tabbar5:
            PlaceholderTabRootView(title: title)
        }
    }

    private func systemImageName(for descriptor: TabBarItemDescriptor) -> String {
        coordinator.selectedTab == descriptor.item
            ? descriptor.selectedSystemImage
            : descriptor.systemImage
    }
}
