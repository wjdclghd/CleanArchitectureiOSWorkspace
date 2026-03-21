//
//  SearchAppStoreItemDTO.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/18/26.
//

import Foundation

struct SearchAppStoreItemDTO: Codable {
    let trackId: Int
    let trackName: String?
    let artistName: String?
    let artworkUrl100: String?
    let description: String?
    let averageUserRating: Double?
    let userRatingCount: Int?
    let screenshotUrls: [String]?
    let genres: [String]?
}
