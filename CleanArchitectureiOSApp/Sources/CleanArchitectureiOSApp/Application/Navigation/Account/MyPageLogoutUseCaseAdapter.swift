//
//  MyPageLogoutUseCaseAdapter.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 5/13/26.
//

import FeatureMyPage

/// App Target의 로그아웃 UseCase를 `MyPageLogoutUseCaseProtocol`로 노출하는 어댑터입니다.
struct MyPageLogoutUseCaseAdapter: MyPageLogoutUseCaseProtocol {
    private let executeHandler: () async throws -> Void

    init(execute: @escaping () async throws -> Void) {
        self.executeHandler = execute
    }

    func execute() async throws {
        try await executeHandler()
    }
}
