//
//  StackHostView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/6/26.
//

import Foundation
import SwiftUI
import Navigation

//@available(iOS 16.0, *)
//struct StackHostView: View {
//    private let container: DIContainer
//    
//    @StateObject private var stack = StackNavigator<AppRoute>()
//    
//    init(container: DIContainer) {
//        self.container = container
//    }
//    
//    var body: some View {
//        let navigator = Navigator(stack)
//        let coordinator = NavigationCoordinator(container: container, navigator: navigator)
//        
//        NavigationStack(path: $stack.path) {
//            coordinator.rootView()
//                .navigationDestination(for: AppRoute.self) { route in
//                    coordinator.build(route: route)
//                }
//        }
//        .sheet(isPresented: Binding(
//            get: { stack.presented != nil },
//            set: { if !$0 { stack.dismiss() } }
//        )) {
//            if let route = stack.presented {
//                coordinator.build(route: route)
//            }
//        }
//    }
//}
