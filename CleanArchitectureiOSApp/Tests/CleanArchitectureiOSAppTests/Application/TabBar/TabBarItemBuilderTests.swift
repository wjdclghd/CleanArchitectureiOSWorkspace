//
//  TabBarItemBuilderTests.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/14/26.
//

import XCTest
@testable import CleanArchitectureiOSApp

final class TabBarItemBuilderTests: XCTestCase {
    func test_makeItems_whenLoggedOut_usesLoginTitleForThirdTab() {
        // given / when
        let items = TabBarItemBuilder.makeItems(loginState: .loggedOut)

        // then
        XCTAssertEqual(items.count, 5)
        XCTAssertEqual(items[2].item, .account)
        XCTAssertEqual(items[2].title, "로그인")
    }

    func test_makeItems_whenLoggedIn_usesMyPageTitleForThirdTab() {
        // given / when
        let items = TabBarItemBuilder.makeItems(loginState: .loggedIn)

        // then
        XCTAssertEqual(items.count, 5)
        XCTAssertEqual(items[2].item, .account)
        XCTAssertEqual(items[2].title, "마이페이지")
    }
}
