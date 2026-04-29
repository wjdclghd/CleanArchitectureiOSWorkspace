//
//  Project.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 12/19/25.
//

import ProjectDescription

let settings: Settings = .settings(
  base: [:],
  configurations: [
    .debug(name: "Debug", xcconfig: .relativeToManifest("Configurations/Debug.xcconfig")),
    .release(name: "Release", xcconfig: .relativeToManifest("Configurations/Release.xcconfig")),
  ],
  defaultSettings: .recommended
)

let appTargetSettings: Settings = .settings(
  base: [
    "ASSETCATALOG_COMPILER_APPICON_NAME": ""
  ]
)

let project = Project(
  name: "CleanArchitectureiOSApp",
  settings: settings,
  targets: [
    .target(
      name: "CleanArchitectureiOSApp",
      destinations: .iOS,
      product: .app,
      bundleId: "com.jch.CleanArchitectureiOSApp",
      deploymentTargets: .iOS("15.0"),
      infoPlist: .extendingDefault(with: [
        "KAKAO_REST_API_KEY": "$(KAKAO_REST_API_KEY)",
        "CHAT_GPT_API_KEY": "$(CHAT_GPT_API_KEY)",
        "UILaunchStoryboardName": .string("LaunchScreen"),
        "UIRequiresFullScreen": .boolean(true)
      ]),
      sources: ["Sources/**"],
      resources: [
        .glob(pattern: "Sources/Resources/**")
      ],
      dependencies: [
        .external(name: "FeatureIntro"),
        .external(name: "FeatureHome"),
        .external(name: "FeatureLogin"),
        .external(name: "FeatureMyPage"),
        .external(name: "FeatureSetting"),
        
        .external(name: "FeatureSearch"),
        .external(name: "FeatureSearchAppStore"),
        
        .external(name: "AppDomain"),
        .external(name: "AppData"),
        
        .external(name: "Navigation"),
        .external(name: "Networking"),
        .external(name: "Persistence"),
        .external(name: "SearchEngine"),
        .external(name: "DesignSystem")
      ],
      settings: appTargetSettings
    ),
    .target(
      name: "CleanArchitectureiOSAppTests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "com.jch.CleanArchitectureiOSAppTests",
      deploymentTargets: .iOS("15.0"),
      infoPlist: .default,
      sources: ["Tests/**"],
      dependencies: [.target(name: "CleanArchitectureiOSApp")]
    )
  ]
)
