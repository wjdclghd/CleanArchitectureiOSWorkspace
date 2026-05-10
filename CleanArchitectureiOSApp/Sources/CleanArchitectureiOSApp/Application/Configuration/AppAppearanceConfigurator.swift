//
//  AppAppearanceConfigurator.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 5/5/26.
//

import UIKit
import DesignSystem

enum AppAppearanceConfigurator {
    static func configure() {
        configureNavigationBar()
        configureTabBar()
    }
}

private extension AppAppearanceConfigurator {
    static func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
        UINavigationBar.appearance().shadowImage = UIImage()
    }

    static func configureTabBar() {
        let policy = DSTabBarStylePolicy.standard
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        configureTabBarItems(appearance.stackedLayoutAppearance, policy: policy)
        configureTabBarItems(appearance.inlineLayoutAppearance, policy: policy)
        configureTabBarItems(appearance.compactInlineLayoutAppearance, policy: policy)

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().tintColor = DSColor.uiColor(for: policy.selectedColorRole)
        UITabBar.appearance().unselectedItemTintColor = DSColor.uiColor(for: policy.unselectedColorRole)
        UITabBar.appearance().shadowImage = UIImage()
    }

    static func configureTabBarItems(
        _ itemAppearance: UITabBarItemAppearance,
        policy: DSTabBarStylePolicy
    ) {
        let selectedColor = DSColor.uiColor(for: policy.selectedColorRole)
        let unselectedColor = DSColor.uiColor(for: policy.unselectedColorRole)

        itemAppearance.selected.iconColor = selectedColor
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: selectedColor]
        itemAppearance.normal.iconColor = unselectedColor
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: unselectedColor]
    }
}
