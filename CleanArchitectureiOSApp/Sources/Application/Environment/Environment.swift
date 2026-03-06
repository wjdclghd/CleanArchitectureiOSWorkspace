//
//  Environment.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 12/19/25.
//

import Foundation

enum Environment {
    static let kakaoKey: String? = Bundle.main.object(forInfoDictionaryKey: "KAKAO_REST_API_KEY") as? String
}
