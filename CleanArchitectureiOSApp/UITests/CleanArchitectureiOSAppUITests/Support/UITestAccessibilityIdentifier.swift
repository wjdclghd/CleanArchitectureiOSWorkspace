//
//  UITestAccessibilityIdentifier.swift
//  CleanArchitectureiOSAppUITests
//
//  Created by Codex on 5/6/26.
//

enum UITestAccessibilityIdentifier {
    enum TabBar {
        static let accountButton = "tab.account.button"
    }

    enum Account {
        static let loginRoot = "account.login.root"
        static let myPageRoot = "account.myPage.root"
    }

    enum Login {
        static let emailTextField = "login.emailTextField"
        static let passwordSecureField = "login.passwordSecureField"
        static let submitButton = "login.submitButton"
    }

    enum Home {
        static let searchEntry = "home.search.entry"
    }

    enum Search {
        static let input = "search.input"
        static func candidate(keyword: String) -> String {
            "search.candidate.\(keyword)"
        }
    }

    enum SearchResult {
        static func item(trackId: Int) -> String {
            "searchResults.item.\(trackId)"
        }
    }

    enum SearchDetail {
        static let title = "searchDetail.title"
    }
}
