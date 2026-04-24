//
//  HomeNavigator.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import Foundation
import Navigation
import FeatureSearchAppStore

/*
 Home 화면 흐름에서 사용하는 App 레벨 navigator입니다.

 이 타입은 HomeRoute 기반의 실제 화면 이동을 수행하며,
 FeatureSearchAppStore가 요구하는 coordinator 계약도 함께 구현합니다.

 담당 역할
 - SearchAppStore 목록 화면 이동
 - SearchAppStore 상세 화면 이동
 - 현재 navigation stack의 pop 처리
 - 루트 화면으로 복귀 처리
 - modal dismiss 처리

 담당하지 않는 역할
 - Feature 내부 View / ViewModel 생성
 - 비즈니스 입력 검증
 - SearchAppStore 화면 상태 관리
 */
@MainActor
final class HomeNavigator: SearchAppStoreCoordinatorProtocol {
    private let navigator: Navigator<HomeRoute>

    /*
     HomeNavigator를 생성합니다.

     Parameters:
     - navigator: HomeRoute 기반 화면 이동을 수행하는 Navigator
     */
    init(navigator: Navigator<HomeRoute>) {
        self.navigator = navigator
    }

    /*
     SearchAppStore 목록 화면으로 이동합니다.

     Parameters:
     - keyword: 목록 화면 진입 시 사용할 검색 키워드
     */
    func showSearchAppStoreList(keyword: String) {
        navigator.push(.searchAppStoreList(keyword: keyword))
    }

    /*
     SearchAppStore 상세 화면으로 이동합니다.

     Parameters:
     - trackId: 상세 조회에 사용할 앱 식별자
     */
    func showSearchAppStoreDetail(trackId: Int) {
        navigator.push(.searchAppStoreDetail(trackId: trackId))
    }

    /*
     현재 화면을 이전 화면으로 되돌립니다.
     */
    func pop() {
        navigator.pop()
    }

    /*
     navigation stack을 루트 화면으로 되돌립니다.
     */
    func popToRoot() {
        navigator.popToRoot()
    }

    /*
     현재 표시 중인 modal 화면을 닫습니다.
     */
    func dismiss() {
        navigator.dismiss()
    }
}
