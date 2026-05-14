// swift-tools-version: 5.9

//
//  Package.swift
//  CleanArchitectureiOSWorkspace
//
//  Created by jch on 12/19/25.
//

import PackageDescription

let package = Package(
    name: "CleanArchitectureiOSWorkspace",
    platforms: [
        .iOS(.v15)
    ],
    dependencies: [
        .package(path: "../Modules/Features/FeatureIntro"),
        .package(path: "../Modules/Features/FeatureHome"),
        .package(path: "../Modules/Features/FeatureLogin"),
        .package(path: "../Modules/Features/FeatureMyPage"),
        .package(path: "../Modules/Features/FeatureSetting"),
        
        .package(path: "../Modules/Features/FeatureSearch"),
        .package(path: "../Modules/Features/FeatureSearchAppStore"),
        
        .package(path: "../Modules/Shared/AppDomain"),
        .package(path: "../Modules/Shared/AppData"),
        
        .package(path: "../Modules/Core/Navigation"),
        .package(path: "../Modules/Core/Infrastructure/Networking"),
        .package(path: "../Modules/Core/Infrastructure/Keychain"),
        .package(path: "../Modules/Core/Infrastructure/Persistence"),
        .package(path: "../Modules/Core/Infrastructure/SearchEngine"),
        .package(path: "../Modules/Core/Infrastructure/ImagePipeline"),
        .package(path: "../Modules/Core/UI/UIComponents"),
        .package(path: "../Modules/Core/UI/DesignSystem")
    ]
)
