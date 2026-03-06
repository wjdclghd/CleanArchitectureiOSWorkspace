//
//  LegacyNavigationState.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/6/26.
//

import Foundation

final class LegacyNavigationState<Route: Hashable>: ObservableObject {
    @Published var stack: [Route] = []
    @Published var presented: Route? = nil
}
