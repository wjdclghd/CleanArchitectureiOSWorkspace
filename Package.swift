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
        .package(path: "../FeatureModules/FeatureSearchAppStore"),
        
        .package(path: "../Modules/AppDomain"),
        .package(path: "../Modules/AppData"),
        
        .package(path: "../Modules/Navigation"),
        .package(path: "../Modules/Networking"),
        .package(path: "../Modules/Persistence"),
        .package(path: "../Modules/SearchEngine"),
        .package(path: "../Modules/DesignSystem")
    ]
)
