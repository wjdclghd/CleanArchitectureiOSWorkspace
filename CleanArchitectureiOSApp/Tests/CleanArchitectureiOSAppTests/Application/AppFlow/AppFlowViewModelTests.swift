//
//  AppFlowViewModelTests.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/14/26.
//

import XCTest
@testable import CleanArchitectureiOSApp

@MainActor
final class AppFlowViewModelTests: XCTestCase {
    func test_init_setsIntroState() {
        let sut = AppFlowViewModel()

        XCTAssertEqual(sut.appFlowState, .intro)
    }

    func test_completeIntro_movesToTabBar() {
        let sut = AppFlowViewModel()

        sut.completeIntro()

        XCTAssertEqual(sut.appFlowState, .tabBar)
    }
}
