//
//  UITestSearchStubData.swift
//  CleanArchitectureiOSApp
//
//  Created by Codex on 5/6/26.
//

import Foundation
import AppDomain

enum UITestSearchStubData {
    static let searchKeyword = "카카오"
    static let trackId = 1001

    static var candidates: [SearchCandidateEntity] {
        [
            SearchCandidateEntity(
                id: "recent-kakao",
                keyword: searchKeyword,
                kind: .recent(historyId: "recent-kakao")
            ),
            SearchCandidateEntity(
                id: "suggestion-kakaotalk",
                keyword: "카카오톡",
                kind: .suggestion
            )
        ]
    }

    static var listItems: [SearchAppStoreListEntity] {
        [
            SearchAppStoreListEntity(
                trackId: trackId,
                trackName: "카카오톡",
                artistName: "Kakao Corp.",
                artworkUrl100: nil,
                averageUserRating: 4.2,
                userRatingCount: 1200
            ),
            SearchAppStoreListEntity(
                trackId: 1002,
                trackName: "카카오맵",
                artistName: "Kakao Corp.",
                artworkUrl100: nil,
                averageUserRating: 4.6,
                userRatingCount: 980
            )
        ]
    }

    static var detailItem: SearchAppStoreDetailEntity {
        SearchAppStoreDetailEntity(
            trackId: trackId,
            trackName: "카카오톡",
            artistName: "Kakao Corp.",
            artworkUrl100: nil,
            description: "UI 테스트에서 사용하는 App Store 상세 설명입니다.",
            averageUserRating: 4.2,
            userRatingCount: 1200,
            screenshotUrls: [],
            genres: ["소셜 네트워킹"]
        )
    }
}
