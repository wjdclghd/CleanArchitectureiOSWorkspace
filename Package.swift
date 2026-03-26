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
        .package(path: "../Modules/Navigation"),
        .package(path: "../Modules/Networking"),
        .package(path: "../Modules/Persistence"),
        .package(url: "https://github.com/realm/realm-swift.git", .upToNextMajor(from: "20.0.4")),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.11.1"))
    ]
)
