//
//  SearchAppStoreEntity.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/17/26.
//

import Foundation

struct SearchAppStoreDetailEntity: Identifiable, Equatable, Hashable {
    let trackId: Int
    var id: Int { trackId }
    
    let trackName: String
    let artistName: String
    let artworkUrl100: String?
    let description: String?
    let averageUserRating: Double?
    let userRatingCount: Int?
    let screenshotUrls: [String]
    let genres: [String]

    init(
        trackId: Int,
        trackName: String,
        artistName: String,
        artworkUrl100: String?,
        description: String?,
        averageUserRating: Double?,
        userRatingCount: Int?,
        screenshotUrls: [String],
        genres: [String]
    ) {
        self.trackId = trackId
        self.trackName = trackName
        self.artistName = artistName
        self.artworkUrl100 = artworkUrl100
        self.description = description
        self.averageUserRating = averageUserRating
        self.userRatingCount = userRatingCount
        self.screenshotUrls = screenshotUrls
        self.genres = genres
    }
}
