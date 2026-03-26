//
//  AppStoreEndpoint.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/26/26.
//

import Foundation
import Networking

enum AppStoreEndpoint {
    private static let baseURL = URL(string: "https://itunes.apple.com")!

    static func searchList(searchKeyword: String) -> Endpoint {
        Endpoint(
            baseURL: baseURL,
            path: "/search",
            method: .get,
            queryItems: [
                URLQueryItem(name: "term", value: searchKeyword),
                URLQueryItem(name: "country", value: "KR"),
                URLQueryItem(name: "media", value: "software"),
                URLQueryItem(name: "entity", value: "software")
            ]
        )
    }

    static func detail(trackId: Int) -> Endpoint {
        Endpoint(
            baseURL: baseURL,
            path: "/lookup",
            method: .get,
            queryItems: [
                URLQueryItem(name: "id", value: String(trackId)),
                URLQueryItem(name: "country", value: "KR")
            ]
        )
    }
}
