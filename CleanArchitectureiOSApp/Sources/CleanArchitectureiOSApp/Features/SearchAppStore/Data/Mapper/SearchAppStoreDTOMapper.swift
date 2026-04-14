//
//  SearchAppStoreDTOMapper.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/18/26.
//

import Foundation

enum SearchAppStoreDTOMapper {
    static func toListItemEntity(from dto: SearchAppStoreItemDTO) -> SearchAppStoreListEntity {
        SearchAppStoreListEntity(
            trackId: dto.trackId,
            trackName: dto.trackName ?? "",
            artistName: dto.artistName ?? "",
            artworkUrl100: dto.artworkUrl100,
            averageUserRating: dto.averageUserRating,
            userRatingCount: dto.userRatingCount
        )
    }

    static func toDetailEntity(from dto: SearchAppStoreItemDTO) -> SearchAppStoreDetailEntity {
        SearchAppStoreDetailEntity(
            trackId: dto.trackId,
            trackName: dto.trackName ?? "",
            artistName: dto.artistName ?? "",
            artworkUrl100: dto.artworkUrl100,
            description: dto.description,
            averageUserRating: dto.averageUserRating,
            userRatingCount: dto.userRatingCount,
            screenshotUrls: dto.screenshotUrls ?? [],
            genres: dto.genres ?? []
        )
    }
}
