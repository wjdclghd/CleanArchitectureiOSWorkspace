//
//  AccountTabRootView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import SwiftUI

struct AccountTabRootView: View {
    private let container: DIContainer
    @ObservedObject private var sessionController: SessionController

    init(container: DIContainer, sessionController: SessionController) {
        self.container = container
        self._sessionController = ObservedObject(wrappedValue: sessionController)
    }

    var body: some View {
        AccountNavigationView(
            container: container,
            sessionController: sessionController
        )
    }
}
