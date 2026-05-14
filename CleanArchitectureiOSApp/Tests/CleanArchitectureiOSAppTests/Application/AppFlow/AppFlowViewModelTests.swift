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
        // given / when
        let sut = AppFlowViewModel()

        // then
        XCTAssertEqual(sut.appFlowState, .intro)
    }

    @MainActor
    func test_completeIntro_movesToTabBar() {
        // given
        let sut = AppFlowViewModel()

        // when
        sut.completeIntro()

        // then
        XCTAssertEqual(sut.appFlowState, .tabBar)
    }
}
