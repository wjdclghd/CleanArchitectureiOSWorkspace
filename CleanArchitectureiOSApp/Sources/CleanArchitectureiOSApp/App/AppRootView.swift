//
//  AppRootView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/11/26.
//

import Foundation
import SwiftUI

struct AppRootView: View {
    @State private var bootstrapState: BootstrapState = .loading

    var body: some View {
        Group {
            switch bootstrapState {
            case .loading:
                ProgressView()
            case .loaded(let container):
                AppFlowView(
                    container: container,
                    viewModel: AppFlowViewModel()
                )
            case .failed(let message):
                VStack(spacing: 12) {
                    Text("앱을 준비하지 못했습니다.")
                        .font(.headline)
                    Text(message)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
            }
        }
        .task {
            await loadContainerIfNeeded()
        }
    }
}

private extension AppRootView {
    enum BootstrapState {
        case loading
        case loaded(DIContainer)
        case failed(String)
    }

    @MainActor
    func loadContainerIfNeeded() async {
        guard case .loading = bootstrapState else {
            return
        }

        do {
            bootstrapState = .loaded(try await DIContainer.makeDefault())
        } catch {
            bootstrapState = .failed(error.localizedDescription)
        }
    }
}
