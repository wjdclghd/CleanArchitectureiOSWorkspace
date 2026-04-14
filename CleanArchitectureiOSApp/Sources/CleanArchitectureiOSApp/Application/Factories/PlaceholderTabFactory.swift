//
//  PlaceholderTabFactory.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import SwiftUI

struct PlaceholderTabFactory {
    func makePlaceholderView(title: String) -> AnyView {
        AnyView(
            PlaceholderView(
                title: title
            )
        )
    }
}
