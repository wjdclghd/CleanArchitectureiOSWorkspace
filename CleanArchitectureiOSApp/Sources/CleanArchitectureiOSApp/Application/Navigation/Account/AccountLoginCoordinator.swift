//
//  AccountLoginCoordinator.swift
//  CleanArchitectureiOSApp
//
//  Created by Codex on 5/11/26.
//

import FeatureLogin
import AppDomain

@MainActor
final class AccountLoginCoordinator: LoginCoordinatorProtocol {
    private let sessionController: SessionController

    init(sessionController: SessionController) {
        self.sessionController = sessionController
    }

    func loginSucceeded(session: AuthSessionEntity) {
        sessionController.authenticate(with: session)
    }
}
