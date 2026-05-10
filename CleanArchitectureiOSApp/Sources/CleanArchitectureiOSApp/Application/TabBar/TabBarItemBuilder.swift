//
//  TabBarItemBuilder.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import Foundation

struct TabBarItemDescriptor: Hashable {
    let item: TabBarItem
    let title: String
    let systemImage: String
    let selectedSystemImage: String
}

enum TabBarItemBuilder {
    static func makeItems(loginState: LoginState) -> [TabBarItemDescriptor] {
        [
            TabBarItemDescriptor(
                item: .home,
                title: "홈",
                systemImage: "house",
                selectedSystemImage: "house.fill"
            ),
            TabBarItemDescriptor(
                item: .tabbar2,
                title: "준비중",
                systemImage: "square.grid.2x2",
                selectedSystemImage: "square.grid.2x2.fill"
            ),
            TabBarItemDescriptor(
                item: .account,
                title: loginState == .loggedIn ? "마이페이지" : "로그인",
                systemImage: "person.circle",
                selectedSystemImage: "person.circle.fill"
            ),
            TabBarItemDescriptor(
                item: .tabbar4,
                title: "준비중",
                systemImage: "star",
                selectedSystemImage: "star.fill"
            ),
            TabBarItemDescriptor(
                item: .tabbar5,
                title: "준비중",
                systemImage: "ellipsis.circle",
                selectedSystemImage: "ellipsis.circle.fill"
            )
        ]
    }
}
