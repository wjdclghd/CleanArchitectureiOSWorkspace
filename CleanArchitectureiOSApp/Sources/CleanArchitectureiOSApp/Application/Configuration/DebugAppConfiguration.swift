//
//  AppConfiguration.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/11/26.
//

import Foundation

struct DebugAppConfiguration: AppConfigurationProtocol {
    var kakaoRESTAPIKey: String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: "KAKAO_REST_API_KEY") as? String,
              !value.isEmpty else {
            assertionFailure("KAKAO_REST_API_KEY is missing in Info.plist")
            return ""
        }
        return value
    }
}
