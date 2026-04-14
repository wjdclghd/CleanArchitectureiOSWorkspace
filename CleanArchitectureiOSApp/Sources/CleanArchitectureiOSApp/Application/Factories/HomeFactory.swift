//
//  HomeFactory.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import SwiftUI

struct HomeFactory {
    func makeHomeView(onSearchRequested: @escaping (String) -> Void) -> AnyView {
        AnyView(
            HomeView(
                onSearchRequested: onSearchRequested
            )
        )
    }
}
