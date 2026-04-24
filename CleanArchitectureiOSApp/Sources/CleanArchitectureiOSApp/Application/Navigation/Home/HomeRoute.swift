//
//  HomeRoute.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import Foundation

/*
 Home 영역에서 사용하는 route 정의입니다.

 이 타입은 Home 흐름에서 발생하는 화면 전환 경로를 enum으로 표현하며,
 App 레벨 navigator가 실제 push / pop 수행 시 기준으로 사용합니다.

 담당 역할
 - SearchAppStore 목록 화면 route 정의
 - SearchAppStore 상세 화면 route 정의
 - 각 route를 식별할 수 있는 고유 식별자 제공

 담당하지 않는 역할
 - 실제 화면 생성
 - 화면 이동 수행
 - 비즈니스 입력 검증
 */
enum HomeRoute: Hashable, Identifiable {
    case searchAppStoreList(keyword: String)
    case searchAppStoreDetail(trackId: Int)

    /*
     route를 구분하기 위한 고유 식별자입니다.

     목록 route는 keyword를 포함한 식별자를 사용하고,
     상세 route는 trackId를 포함한 식별자를 사용합니다.
     */
    var id: String {
        switch self {
        case .searchAppStoreList(let keyword):
            return "search.list.\(keyword)"
        case .searchAppStoreDetail(let trackId):
            return "search.detail.\(trackId)"
        }
    }
}
