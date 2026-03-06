//
//  Tuist.swift
//  CleanArchitectureiOSWorkspace
//
//  Created by jch on 12/19/25.
//

import ProjectDescription

let tuist = Tuist(
    project: .tuist(
        // CI/CD 환경에서도 Xcode 버전 차이로 깨지지 않도록
        compatibleXcodeVersions: .all
    )
)
