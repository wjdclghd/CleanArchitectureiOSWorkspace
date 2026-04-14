//
//  MyPageFactory.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import SwiftUI

struct MyPageFactory {
    func makeMyPageView(
        onOpenSettings: @escaping () -> Void,
        onLogout: @escaping () -> Void
    ) -> AnyView {
        AnyView(
            MyPageView(
                onOpenSettings: onOpenSettings,
                onLogout: onLogout
            )
        )
    }
}
