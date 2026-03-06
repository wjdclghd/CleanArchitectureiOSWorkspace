## TaskProject — Clean Architecture iOS
- SwiftUI + Combine + Module + Clean Architecture 구조로 구현한 검색(카카오 API) 데모 앱입니다.
  Network와 Database를 담당하는 CoreModule과 Feature 모듈 SearchFeatureModule 
  App 타겟 CleanSprint를 Tuist로 관리하고 테스트/CI는 Fastlane/Bundler로 구성했습니다.
---


## 구성
- TaskProject/
  ├─ CleanSprint/                 # iOS App 타겟
  │  └─ Sources/Application
  │     ├─ DI/                    # 의존성 주입 UseCase/Repository 구성(컨테이너)
  │     ├─ Environment/           # 환경값 Info.plist 키 주입
  │     ├─ Factory/               # View/ViewModel 생성 Factory, 화면 조립
  │     ├─ Legacy/                # 과거 버전(이전 API/모듈/플로우)하위 iOS 버전 대응
  │     ├─ Navigation/            # Router/Coordinator 화면 전환 관리
  ├─ CoreModule/                  # 공용 Core (Network/DB)
  │  ├─ Sources/CoreNetwork/      # Alamofire 기반 API 클라이언트
  │  └─ Sources/CoreDatabase/     # RealmSwift 및 마이그레이션
  ├─ SearchFeatureModule/         # 검색 기능 모듈 (Presentation + Domain + Data)
  │  └─ Sources/SearchFeatureModule/
  │     ├─ SearchList/            # Repository / UseCase / ViewModel /View
  │     ├─ SearchDetailList/      # Repository / UseCase / ViewModel /View
  │     └─ SearchDetail/          # /View
  │     Components, Support       # 공용 뷰/유틸
  └─ TaskProject.xcworkspace      # 통합 워크스페이스
---


## 기술 스택
- Language: Swift 5.9+
- UI: SwiftUI
- Reactive: Combine
- Network: Alamofire
- DB: RealmSwift
- Build: Tuist  
- Pkg: Swift Package Manager 
- GitHub Actions: CI/CD pipeline integration 
- Test: XCTest (Combine 테스트)
- CI: Fastlane (로컬 실행 기준)
---


## Tools & Setup
- Xcode 16 (iOS 15+ 타겟)
- SwiftPM 사용 가능 환경
- Ruby 3.2 + Bundler(Fastlane 실행용)
- Tuist
---


## Tuist 설치 방법
- TaskProject/ 디렉토리 이동 후 아래 명령어 실행
- $ brew install mise
- $ mise install tuist@latest
---

## Fastlane / Bundler 설치 방법
- 각 Module(CoreModule, SearchFeatureModule) 디렉토리로 이동 후 아래 명령어 실행
- $ gem install bundler
- $ bundle install
---


## 환경 변수(API 키)
- App 타겟에서 카카오 Rest API키를 Info.plist로 전달합니다.
- InfoPlist 설정 (CleanSprint/Project.swift) 
  KAKAO_REST_API_KEY → $(KAKAO_REST_API_KEY)
- xcconfig에 명시 
  CleanSprint/Configurations/Debug.xcconfig
---


## 빌드 & 실행
- TaskProject 디렉토리 이동
- $ tuist clean
- $ tuist install
- $ tuist generate
- $ open TaskProject.xcworkspace
- CleanSprint 타겟 선택
- 시뮬레이터 iOS 15+ 기기 선택
---


## CI/CD Pipeline (local지원)
- 현제는 CI local만 지원
- 각 Module(CoreModule, SearchFeatureModule) 디렉토리 이동 후 아래 명령어 실행
- $ bundle exec fastlane unit_test
---


## Notes for Collaborators
- 
---


## License

---


> Created by: JEONG, Chi-hong
> Initial version: June 2025
