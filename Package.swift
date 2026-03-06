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
//        .package(path: "../SearchFeatureModule"),
        .package(path: "../Modules/CoreModule"),
        .package(path: "../Modules/Navigation"),
        .package(url: "https://github.com/realm/realm-swift.git", .upToNextMajor(from: "10.47.0")),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.9.1"))
    ]
)
