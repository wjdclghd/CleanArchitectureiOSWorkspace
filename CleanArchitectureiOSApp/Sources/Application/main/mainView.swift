//
//  mainView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/6/26.
//

import Foundation
import SwiftUI

//struct MainMenuView<Coordinator: NavigationCoordinatorProtocol>: View where Coordinator.Route == AppRoute {
//    @ObservedObject var coordinator: Coordinator
//
//    var body: some View {
//        NavigationStack(path: $coordinator.path) {
//            VStack(spacing: 16) {
//                Text("")
//                    .font(.title)
//                
//                Button {
//                    coordinator.push(route: .searchList)
//                } label: {
//                    Label("Search List", systemImage: "magnifyingglass")
//                }
//                
//                Button {
//                    coordinator.push(route: .chatGPTSearch)
//                } label: {
//                    Label("ChatGPT Search", systemImage: "magnifyingglass")
//                }
//                
//                Button {
//                    coordinator.push(route: .userRecommendation)
//                } label: {
//                    Label("userRecommendation", systemImage: "magnifyingglass")
//                }
//            }
//            .navigationDestination(for: AppRoute.self) { route in
//                coordinator.build(route: route)
//            }
//        }
//    }
//}
