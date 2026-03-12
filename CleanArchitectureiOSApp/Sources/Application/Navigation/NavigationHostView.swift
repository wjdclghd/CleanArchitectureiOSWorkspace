//
//  NavigationHostView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/11/26.
//

import Foundation
import SwiftUI

struct NavigationHostView: View {
    private let container: DIContainer
    
    private let onLogout: () -> Void
    
    init(container: DIContainer, onLogout: @escaping () -> Void) {
        self.container = container
        
        self.onLogout = onLogout
    }
    
    var body: some View {
        Group {
            if #available(iOS 16.0, *) {
                StackHostView(container: container, onLogout: onLogout)
            } else {
                LegacyHostView(container: container, onLogout: onLogout)
            }
        }
    }
}
