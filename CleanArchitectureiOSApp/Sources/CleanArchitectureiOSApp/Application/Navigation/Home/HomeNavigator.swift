//
//  HomeNavigator.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import Foundation
import Navigation

@MainActor
final class HomeNavigator {
    private let navigator: Navigator<HomeRoute>

    init(navigator: Navigator<HomeRoute>) {
        self.navigator = navigator
    }

    func showSearchAppStoreList(keyword: String) {
        navigator.push(.searchAppStoreList(keyword: keyword))
    }

    func showSearchAppStoreDetail(trackId: Int) {
        navigator.push(.searchAppStoreDetail(trackId: trackId))
    }

    func pop() {
        navigator.pop()
    }

    func popToRoot() {
        navigator.popToRoot()
    }

    func dismiss() {
        navigator.dismiss()
    }
}
