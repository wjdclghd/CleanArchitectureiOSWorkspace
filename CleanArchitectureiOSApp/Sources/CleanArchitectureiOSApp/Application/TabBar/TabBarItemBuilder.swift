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
}

enum TabBarItemBuilder {
    static func makeItems(loginState: LoginState) -> [TabBarItemDescriptor] {
        [
            TabBarItemDescriptor(item: .home, title: "홈", systemImage: "house"),
            TabBarItemDescriptor(item: .tabbar2, title: "준비중", systemImage: "square.grid.2x2"),
            TabBarItemDescriptor(
                item: .account,
                title: loginState == .loggedIn ? "마이페이지" : "로그인",
                systemImage: "person.circle"
            ),
            TabBarItemDescriptor(item: .tabbar4, title: "준비중", systemImage: "star"),
            TabBarItemDescriptor(item: .tabbar5, title: "준비중", systemImage: "ellipsis.circle")
        ]
    }
}
