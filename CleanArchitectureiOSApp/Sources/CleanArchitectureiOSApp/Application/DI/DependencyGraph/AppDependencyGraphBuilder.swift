//
//  AppDependencyGraphBuilder.swift
//  CleanArchitectureiOSApp
//
//  Created by Codex on 5/6/26.
//

import Foundation

enum AppDependencyGraphBuilder {
    @MainActor
    static func makeContainer(environment: AppEnvironment) async throws -> DIContainer {
        switch environment.dependencyProfile {
        case .production:
            return try await ProductionDependencyBuilder.makeContainer(
                environment: environment
            )

        case .uiTestStub(let scenario):
            return try await UITestDependencyBuilder.makeContainer(
                environment: environment,
                scenario: scenario
            )
        }
    }
}
