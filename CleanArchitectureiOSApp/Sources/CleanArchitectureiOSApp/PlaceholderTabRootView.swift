//
//  PlaceholderTabRootView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import SwiftUI

struct PlaceholderTabRootView: View {
    private let title: String
    private let factory = PlaceholderTabFactory()

    init(title: String) {
        self.title = title
    }

    var body: some View {
        NavigationView {
            factory.makePlaceholderView(title: title)
        }
    }
}
