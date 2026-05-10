//
//  AppFlowView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import SwiftUI
import FeatureIntro

struct AppFlowView: View {
    private let container: DIContainer

    @StateObject private var viewModel: AppFlowViewModel

    init(container: DIContainer, viewModel: AppFlowViewModel) {
        self.container = container
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Group {
            switch viewModel.appFlowState {
            case .intro:
                IntroFactory().makeIntroView(
                    onNext: {
                        viewModel.completeIntro()
                    }
                )
            case .tabBar:
                TabBarView(container: container)
            }
        }
    }
}
