//
//  SearchFlowUITests.swift
//  CleanArchitectureiOSAppUITests
//
//  Created by Codex on 5/6/26.
//

import XCTest

final class SearchFlowUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
    }

    override func tearDownWithError() throws {
        app.terminate()
        app = nil
    }

    func test_searchFlow_withStubSearchSuccess_showsDetail() {
        // given
        app.launchForUITest(arguments: [
            UITestLaunchArgument.resetState,
            UITestLaunchArgument.stubSearchSuccess
        ])

        let homePage = HomePageObject(app: app)
        homePage.waitForSearchEntry()

        // when
        let searchPage = homePage.tapSearchEntry()
        searchPage.enterKeyword("카")
        let resultsPage = searchPage.tapCandidate(keyword: "카카오톡")
        resultsPage.waitForResults()
        let detailPage = resultsPage.tapItem(trackId: 1001)

        // then
        detailPage.waitForDetail()
    }
}
