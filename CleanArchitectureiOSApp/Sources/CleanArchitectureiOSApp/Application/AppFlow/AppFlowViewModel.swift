//
//  AppFlowViewModel.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import Foundation
import Combine

@MainActor
final class AppFlowViewModel: ObservableObject {
    @Published private(set) var appFlowState: AppFlowState = .intro

    init() { }

    func completeIntro() {
        appFlowState = .tabBar
    }
}
