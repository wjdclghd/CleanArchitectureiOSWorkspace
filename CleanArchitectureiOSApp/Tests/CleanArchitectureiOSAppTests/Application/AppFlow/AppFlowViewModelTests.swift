//
//  AppFlowViewModelTests.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/14/26.
//

import XCTest
@testable import CleanArchitectureiOSApp

final class AppFlowViewModelTests: XCTestCase {
    @MainActor
    func test_init_setsIntroState() {
        let sut = AppFlowViewModel()

        XCTAssertEqual(sut.appFlowState, .intro)
    }

    @MainActor
    func test_completeIntro_movesToTabBar() {
        let sut = AppFlowViewModel()

        sut.completeIntro()

        XCTAssertEqual(sut.appFlowState, .tabBar)
    }
}
