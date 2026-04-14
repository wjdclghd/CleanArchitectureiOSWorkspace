//
//  SearchAppStoreListEntity.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/18/26.
//

import Foundation

struct SearchAppStoreListEntity: Identifiable, Equatable, Hashable {
    let trackId: Int
    var id: Int { trackId }
    
    let trackName: String
    let artistName: String
    let artworkUrl100: String?
    let averageUserRating: Double?
    let userRatingCount: Int?

    init(
        trackId: Int,
        trackName: String,
        artistName: String,
        artworkUrl100: String?,
        averageUserRating: Double?,
        userRatingCount: Int?
    ) {
        self.trackId = trackId
        self.trackName = trackName
        self.artistName = artistName
        self.artworkUrl100 = artworkUrl100
        self.averageUserRating = averageUserRating
        self.userRatingCount = userRatingCount
    }
}
