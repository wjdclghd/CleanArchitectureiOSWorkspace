# CleanArchitectureiOSWorkspace

SwiftUI + Clean Architecture + MVVM 기반의 **모듈형 iOS Prototype 프로젝트**입니다.

**App Target은 Tuist로 관리**하고, Feature / Shared / Core 계층은 **Swift Package Manager 기반 독립 모듈**로 분리합니다. 현재는 홈, 검색, App Store 검색 목록/상세, 로그인, 로그인 유지, 로그아웃, 마이페이지 흐름을 중심으로 구현되어 있습니다.

---

**프로젝트 목표**

이 프로젝트의 목적은 단순 기능 구현보다 **iOS 프로젝트에서 유지보수 가능한 모듈 구조와 의존성 방향을 검증하는 것**입니다.

주요 목표는 다음과 같습니다.

- SwiftUI 기반 MVVM 화면 구조 정립
- Feature / Shared / Core / App Target 계층 분리
- App Target을 Composition Root로 사용
- Feature 모듈 간 직접 의존 금지
- Feature가 AppData, DTO, DataSource, Repository 구현체를 직접 알지 않는 구조 유지
- 로그인 / 로그아웃 / 로그인 유지 세션 흐름 구현
- Keychain과 Persistence를 분리한 로컬 저장 구조 구현
- AppEnvironment 기반 환경별 baseURL 주입 구조 구현
- UI Test Stub 기반 검색/로그인 흐름 검증

---

**기술 스택**

| 영역 | 사용 기술 |
|---|---|
| Language | Swift 6.x |
| UI | SwiftUI, UIKit Appearance |
| Architecture | Modular Clean Architecture + MVVM |
| App Target 관리 | Tuist |
| Module 관리 | Swift Package Manager |
| Minimum iOS | iOS 15.0 |
| Networking | Core Networking 모듈, Alamofire 5.11.1 |
| Local Persistence | CoreData 기반 Persistence 모듈 |
| Secure Storage | Security Framework 기반 Keychain 모듈 |
| Search Index | SearchEngine 모듈 |
| CI / Test | Fastlane, XCTest, XCUITest, GitHub Actions |

---

**전체 구조**

```text
CleanArchitectureiOSWorkspace
├─ CleanArchitectureiOSApp/              # Tuist 기반 App Target
│  ├─ Project.swift
│  ├─ Configurations/
│  ├─ Sources/CleanArchitectureiOSApp/
│  │  ├─ App/
│  │  ├─ Application/
│  │  │  ├─ AppFlow/
│  │  │  ├─ Configuration/
│  │  │  ├─ DI/
│  │  │  ├─ Navigation/
│  │  │  ├─ TabBar/
│  │  │  └─ UserSession/
│  │  └─ Resources/
│  ├─ Tests/
│  └─ UITests/
├─ Docs/
├─ fastlane/
├─ Package.swift                         # Workspace가 참조하는 SPM local package 목록
├─ Workspace.swift                       # Tuist workspace 정의
└─ Tuist.swift
```

외부 모듈은 Workspace의 상위 경로에 있는 `../Modules` 디렉터리를 기준으로 참조합니다.

```text
../Modules
├─ Features/
│  ├─ FeatureIntro
│  ├─ FeatureHome
│  ├─ FeatureLogin
│  ├─ FeatureMyPage
│  ├─ FeatureSetting
│  ├─ FeatureSearch
│  └─ FeatureSearchAppStore
├─ Shared/
│  ├─ AppDomain
│  └─ AppData
└─ Core/
   ├─ Navigation
   ├─ Infrastructure/
   │  ├─ Networking
   │  ├─ Keychain
   │  ├─ Persistence
   │  ├─ SearchEngine
   │  └─ ImagePipeline
   └─ UI/
      ├─ UIComponents
      └─ DesignSystem
```

> 이 Workspace만 단독으로 열 경우 `../Modules/...` 경로의 Swift Package들이 없으면 패키지 해석이 실패합니다. App Target과 모듈 레포를 함께 배치해야 합니다.

---

**아키텍처 개요**

```text
┌───────────────────────────────────────────────┐
│ CleanArchitectureiOSApp Target                │
│ App Entry / AppEnvironment / DIContainer       │
│ AppFlow / TabBar / RouteBuilder / Navigator    │
└───────────────┬───────────────────────────────┘
                │
                ▼
┌───────────────────────────────────────────────┐
│ Feature Modules                               │
│ FeatureLogin / FeatureMyPage / FeatureSearch  │
│ View / ViewModel / ViewState / Factory         │
│ CoordinatorProtocol                            │
└───────────────┬───────────────────────────────┘
                │
                ▼
┌───────────────────────────────────────────────┐
│ AppDomain                                     │
│ Entity / UseCase / RepositoryProtocol          │
└───────────────▲───────────────────────────────┘
                │
┌───────────────┴───────────────────────────────┐
│ AppData                                       │
│ Repository 구현체 / DTO / Mapper / DataSource │
└───────────────┬───────────────────────────────┘
                │
                ▼
┌───────────────────────────────────────────────┐
│ Core Infrastructure / Core UI                 │
│ Networking / Keychain / Persistence            │
│ SearchEngine / Navigation / DesignSystem       │
└───────────────────────────────────────────────┘
```

**계층별 책임**

| 계층 | 책임 |
|---|---|
| App Target | 앱 진입점, 환경 결정, DI 조립, TabBar, RouteBuilder, App 전역 세션 상태 관리 |
| Feature | SwiftUI View, ViewModel, ViewState, Feature Factory, CoordinatorProtocol |
| AppDomain | Entity, UseCase, RepositoryProtocol, 순수 비즈니스 정책 |
| AppData | Repository 구현체, Remote/Local DataSource, DTO, Mapper |
| Core Infrastructure | Networking, Keychain, Persistence, SearchEngine 등 공통 인프라 |
| Core UI | DesignSystem, UIComponents |

**의존성 원칙**

```text
App Target → Feature / AppDomain / AppData / Core
Feature    → AppDomain / Core UI
AppData    → AppDomain / Core Infrastructure
AppDomain  → Foundation 수준 의존만 허용
```

금지되는 방향:

```text
Feature → AppData
Feature → Repository 구현체
Feature → DTO
Feature → DataSource
Feature → App Target
Feature 모듈 간 직접 의존
```

---

**주요 기능**

**1 AppFlow**

- 앱 실행 후 DIContainer 비동기 초기화
- Bootstrap loading / failed / loaded 상태 처리
- Intro 완료 후 TabBar 진입

**2 TabBar**

현재 5탭 구조를 사용합니다.

| Tab | 현재 상태 |
|---|---|
| Home | 홈 + 검색 진입 |
| tabbar2 | Placeholder |
| Account | 로그인 상태에 따라 Login 또는 MyPage 표시 |
| tabbar4 | Placeholder |
| tabbar5 | Placeholder |

**3 Home / Search / App Store 검색**

- Home 검색 진입 버튼
- 검색 입력 화면 이동
- 최근 검색어 / 검색 후보 조회
- App Store 검색 결과 목록 이동
- App Store 상세 화면 이동
- SearchEngine seed 기반 검색 후보 구성
- Persistence 기반 최근 검색어 저장

**4 Login / Logout / Session Restore**

로그인 관련 흐름은 다음과 같이 분리되어 있습니다.

```text
FeatureLogin
→ LoginViewModel
→ LoginUseCaseProtocol
→ AppDomain.LoginUseCase
→ AppData.AuthRepository
→ AuthRemoteDataSource
→ Keychain / Persistence
```

로그인 성공 시:

```text
token        → Keychain
user session → Persistence
app state    → SessionController
```

로그아웃 흐름:

```text
FeatureMyPage
→ MyPageViewModel
→ MyPageLogoutUseCaseProtocol
→ MyPageLogoutUseCaseAdapter
→ LogoutSessionUseCase
→ AuthRepository.requestLogout()
→ AuthRepository.clearLocalSession()
→ SessionController.signOut()
```

로그인 유지 흐름:

```text
App Launch
→ RestoreSessionUseCase
→ Keychain token 확인
→ refreshToken 만료 검증
→ accessToken 유효 시 저장된 사용자 세션 복원
→ accessToken 만료 시 refresh API 호출
→ 성공 시 새 token + user 저장
→ 실패 시 로컬 세션 정리
```

**5 MyPage**

- 로그인 사용자 nickname / email 표시
- 설정 화면 이동 CoordinatorProtocol 사용
- 로그아웃 버튼 처리
- 로그아웃 진행 상태와 실패 메시지를 ViewState에서 관리

---

**환경 구성**

`baseURL`은 Feature나 Domain이 아니라 **App Target의 AppEnvironment**에서 결정합니다.

```text
AppEnvironment
→ authBaseURL
→ searchAppStoreBaseURL
→ authStorageKey
```

RemoteDataSource는 App Target에서 결정한 URL을 생성자 주입으로 받습니다.

```text
App Target
→ AuthRemoteDataSource(baseURL: environment.authBaseURL)
→ SearchAppStoreDataSource(baseURL: environment.searchAppStoreBaseURL)
```

**Environment Variables**

| Key | 설명 | 예시 |
|---|---|---|
| `APP_DEPENDENCY_PROFILE` | 실행 프로필 | `local`, `development`, `staging`, `production` |
| `AUTH_BASE_URL` | 인증 서버 URL | `http://localhost:8080` |
| `SEARCH_APP_STORE_BASE_URL` | App Store Search API URL | `https://itunes.apple.com` |

**DependencyProfile**

```swift
local
production
development
staging
uiTestStub(UITestScenario)
```

현재 정책:

| Profile | baseURL 정책 |
|---|---|
| local | `http://localhost:8080` fallback 허용 |
| development | 개발 서버 fallback 또는 환경변수 override |
| staging | 스테이징 서버 fallback 또는 환경변수 override |
| production | `AUTH_BASE_URL` 필수. placeholder fallback 없음 |
| uiTestStub | UI Test scenario별 storage key 분리 |

**Xcode Scheme 예시**

로컬 개발:

```text
APP_DEPENDENCY_PROFILE=local
AUTH_BASE_URL=http://localhost:8080
SEARCH_APP_STORE_BASE_URL=https://itunes.apple.com
```

운영 빌드:

```text
APP_DEPENDENCY_PROFILE=production
AUTH_BASE_URL=https://api.your-real-domain.com
SEARCH_APP_STORE_BASE_URL=https://itunes.apple.com
```

---

**로컬 실행 방법**

**1 사전 준비**

- Xcode 16.x
- iOS Simulator iOS 15+
- Tuist
- Ruby / Bundler
- 상위 경로의 `../Modules` Swift Package 모듈들
- 로그인 API 테스트 시 로컬 백엔드 서버

**2 의존성 배치**

Workspace는 모듈을 sibling path로 참조합니다.

```text
ParentDirectory
├─ CleanArchitectureiOSWorkspace
└─ Modules
   ├─ Features
   ├─ Shared
   └─ Core
```

**3 프로젝트 생성**

```bash
tuist install
tuist generate
open CleanArchitectureiOSWorkspace.xcworkspace
```

이미 생성된 workspace를 사용하는 경우:

```bash
open CleanArchitectureiOSWorkspace.xcworkspace
```

**4 로컬 서버 실행**

로그인 API를 실제로 호출하려면 `AUTH_BASE_URL`이 바라보는 서버가 실행 중이어야 합니다.

예:

```text
AUTH_BASE_URL=http://localhost:8080
```

백엔드 로컬 서버가 PostgreSQL을 사용하는 경우, 먼저 PostgreSQL 컨테이너 또는 로컬 DB를 실행해야 합니다.

---

**테스트**

**1 Unit Test**

```bash
bundle exec fastlane unit_test
```

Fastlane은 다음 workspace / scheme 기준으로 테스트합니다.

```text
workspace: CleanArchitectureiOSWorkspace.xcworkspace
scheme: CleanArchitectureiOSApp
```

**2 UI Test**

UI Test는 launch argument 기반 stub scenario를 사용합니다.

| Argument | 설명 |
|---|---|
| `--ui-testing` | UI Test 모드 |
| `--reset-state` | 테스트 상태 초기화 |
| `--stub-search-success` | 검색 성공 Stub |
| `--stub-login-success` | 로그인 성공 Stub |

현재 포함된 주요 UI Test 흐름:

- Search flow: Home → Search → Search Result → Search Detail
- Login flow: Login → MyPage

**3 GitHub Actions / Fastlane**

현재 CI 구성은 Fastlane `unit_test` lane을 중심으로 합니다.

주요 작업:

- Bundler dependency 설치
- Xcode unit test 실행
- `.xcresult` 업로드
- JUnit report 업로드
- coverage 추출
- Danger 실행

---

**주요 문서**

| 문서 | 설명 |
|---|---|
| `Docs/Feature/Home_Search/` | Home Search 연결 조사/계획 |
| `Docs/Feature/Login+MyPage/` | Login / MyPage 조사/계획 |
| `Docs/Feature/Navigation+Tabbar/` | Navigation / TabBar 조사/계획 |

---

**구현 상태**

| 영역 | 상태 |
|---|---|
| App Target Tuist 구성 | 진행 중 |
| 모듈형 DIContainer | 구현 |
| AppEnvironment 기반 baseURL 주입 | 구현 |
| Intro → TabBar AppFlow | 구현 |
| Home Tab | 구현 |
| Search 입력 | 구현 |
| App Store 검색 목록/상세 | 구현 |
| Login | 구현 |
| Logout | 구현 |
| Login 유지 / RestoreSession | 구현 |
| MyPage | 구현 |
| Setting | Placeholder |
| 나머지 Tab | Placeholder |

---

**개발 원칙**

- View는 UI 렌더링과 사용자 이벤트 전달에 집중합니다.
- ViewModel은 ViewState를 관리하고 UseCase를 호출합니다.
- UseCase는 비즈니스 정책을 담당합니다.
- RepositoryProtocol은 AppDomain에 둡니다.
- Repository 구현체는 AppData에 둡니다.
- DTO / Mapper / DataSource는 Feature에 노출하지 않습니다.
- Feature Factory는 View/ViewModel 조립까지만 담당합니다.
- App Target은 실제 의존성 조립과 화면 이동 구현을 담당합니다.
- CoordinatorProtocol은 Feature에 두고, 구현체는 App Target에 둡니다.
- 화면 이동은 MainActor에서 처리합니다.
- token 원문은 Keychain에 저장합니다.
- 사용자 세션 정보는 Persistence에 저장합니다.
- 서버 baseURL은 AppEnvironment에서 결정합니다.

---

**주의 사항**

- `../Modules` 경로의 SPM 모듈들이 없으면 Workspace가 정상적으로 resolve되지 않습니다.
- `production` profile은 `AUTH_BASE_URL`이 필수입니다.
- 현재 개발 단계에서는 일부 서버 URL placeholder가 남아 있을 수 있으므로 운영 배포 전 반드시 Scheme / xcconfig / Info.plist 설정을 확인해야 합니다.
- `tabbar2`, `tabbar4`, `tabbar5`, `FeatureSetting`은 현재 Placeholder 단계입니다.
- 생성된 `.xcodeproj`, `.xcworkspace`, Derived 파일은 Tuist/SwiftPM 정책에 따라 관리합니다.

---

**향후 개선 예정**

- Setting 화면 실제 구현
- 미구현 Tab 기능 확장
- RestoreSession 실패 정책 세분화
  - invalid refresh token
  - inactive user
  - network/server temporary failure
- `any` / `@unchecked Sendable` 정리
- UIComponents 빌드 모듈 활성화
- 운영/개발/스테이징 서버 환경값 확정
- CI workflow 정리 및 자동 트리거 활성화

---

Created by: JEONG, Chi-hong  
Updated: May 2026
