//
//  LoginFactory.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import SwiftUI

struct LoginFactory {
    func makeLoginView(onLoginSuccess: @escaping () -> Void) -> AnyView {
        AnyView(
            LoginView(
                onLoginSuccess: onLoginSuccess
            )
        )
    }
}
