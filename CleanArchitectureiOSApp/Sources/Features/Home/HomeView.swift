//
//  HomeView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/11/26.
//

import Foundation
import SwiftUI

struct HomeView: View {
    private let coordinator: NavigationCoordinator
    
    init(coordinator: NavigationCoordinator, onLogout: @escaping () -> Void = {}) {
        self.coordinator = coordinator
        self.onLogout = onLogout
    }
    
    let onLogout: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Home")
                .font(.largeTitle)

            Button("SearchAppStore") {
                coordinator.push(.searchAppStoreListView(searchKeyword: "네이버"))
            }
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 24)

            Button("Logout") {
                onLogout()
            }
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 24)
        }
        .padding()
        .navigationTitle("Home")
    }
}
