//
//  AppEnvironment.swift
//  CleanArchitectureiOSApp
//
//  Created by Codex on 5/6/26.
//

import Foundation

struct AppEnvironment: Equatable {
    let launchConfiguration: AppLaunchConfiguration
    let dependencyProfile: DependencyProfile

    /// Keychain / Persistence에 저장되는 인증 데이터를 환경별로 분리하기 위한 키입니다.
    var authStorageKey: String {
        switch dependencyProfile {
        case .local:
            return "local"
        case .development:
            return "development"
        case .staging:
            return "staging"
        case .production:
            return "production"
        case .uiTestStub(let scenario):
            return "uiTest-\(scenario.storageKey)"
        }
    }

    /// Auth API baseURL입니다.
    ///
    /// 원칙:
    /// - App Target이 실행 환경에 따른 baseURL을 결정합니다.
    /// - AppData의 RemoteDataSource는 이 값을 주입받아 사용합니다.
    /// - Feature / AppDomain / Endpoint는 실제 서버 주소를 알지 않습니다.
    var authBaseURL: URL {
        switch dependencyProfile {
        case .local:
            return URLResolver.resolve(
                rawValue: launchConfiguration.authBaseURLString,
                fallback: AppEnvironmentDefaults.localAuthBaseURL,
                configurationName: AppEnvironmentKey.authBaseURL
            )

        case .development:
            return URLResolver.resolve(
                rawValue: launchConfiguration.authBaseURLString,
                fallback: AppEnvironmentDefaults.developmentAuthBaseURL,
                configurationName: AppEnvironmentKey.authBaseURL
            )

        case .staging:
            return URLResolver.resolve(
                rawValue: launchConfiguration.authBaseURLString,
                fallback: AppEnvironmentDefaults.stagingAuthBaseURL,
                configurationName: AppEnvironmentKey.authBaseURL
            )

        case .production:
            return URLResolver.resolveRequired(
                rawValue: launchConfiguration.authBaseURLString,
                configurationName: AppEnvironmentKey.authBaseURL
            )

        case .uiTestStub:
            return URLResolver.resolve(
                rawValue: launchConfiguration.authBaseURLString,
                fallback: AppEnvironmentDefaults.uiTestAuthBaseURL,
                configurationName: AppEnvironmentKey.authBaseURL
            )
        }
    }

    /// App Store Search API baseURL입니다.
    var searchAppStoreBaseURL: URL {
        URLResolver.resolve(
            rawValue: launchConfiguration.searchAppStoreBaseURLString,
            fallback: AppEnvironmentDefaults.searchAppStoreBaseURL,
            configurationName: AppEnvironmentKey.searchAppStoreBaseURL
        )
    }

    static func current(
        arguments: [String] = ProcessInfo.processInfo.arguments,
        processEnvironment: [String: String] = ProcessInfo.processInfo.environment,
        infoDictionary: [String: Any] = Bundle.main.infoDictionary ?? [:]
    ) -> AppEnvironment {
        let launchConfiguration = AppLaunchConfiguration.current(
            arguments: arguments,
            processEnvironment: processEnvironment,
            infoDictionary: infoDictionary
        )

        return AppEnvironment(
            launchConfiguration: launchConfiguration,
            dependencyProfile: DependencyProfile.resolve(from: launchConfiguration)
        )
    }
}

enum AppEnvironmentKey {
    static let dependencyProfile = "APP_DEPENDENCY_PROFILE"
    static let authBaseURL = "AUTH_BASE_URL"
    static let searchAppStoreBaseURL = "SEARCH_APP_STORE_BASE_URL"
}

// MARK: - Defaults

private enum AppEnvironmentDefaults {
    static let localAuthBaseURL = "http://localhost:8080"

    /// 개발 서버가 확정되기 전 기본값입니다.
    /// 실제 개발 서버가 생기면 Scheme Environment 또는 Info.plist에서 AUTH_BASE_URL로 덮어쓰세요.
    static let developmentAuthBaseURL = "https://dev-api.your-domain.com"

    /// 스테이징 서버가 확정되기 전 기본값입니다.
    /// 실제 스테이징 서버가 생기면 Scheme Environment 또는 Info.plist에서 AUTH_BASE_URL로 덮어쓰세요.
    static let stagingAuthBaseURL = "https://staging-api.your-domain.com"

    /// UI Test에서는 실제 서버를 사용하지 않더라도 RemoteDataSource 생성에 baseURL이 필요합니다.
    static let uiTestAuthBaseURL = "http://localhost:8080"

    static let searchAppStoreBaseURL = "https://itunes.apple.com"
}

// MARK: - URL Resolver

private enum URLResolver {
    static func resolve(
        rawValue: String?,
        fallback: String,
        configurationName: String
    ) -> URL {
        makeURL(
            from: rawValue ?? fallback,
            configurationName: configurationName
        )
    }

    static func resolveRequired(
        rawValue: String?,
        configurationName: String
    ) -> URL {
        guard let rawValue,
              rawValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false else {
            preconditionFailure(
                "Missing required URL configuration: \(configurationName). " +
                "Set it using Scheme Environment or Info.plist before production build."
            )
        }

        return makeURL(
            from: rawValue,
            configurationName: configurationName
        )
    }

    private static func makeURL(
        from rawValue: String,
        configurationName: String
    ) -> URL {
        let normalizedValue = rawValue.trimmingCharacters(in: .whitespacesAndNewlines)

        guard normalizedValue.isEmpty == false,
              let url = URL(string: normalizedValue) else {
            preconditionFailure(
                "Invalid URL configuration for \(configurationName): \(rawValue)"
            )
        }

        return url
    }
}
