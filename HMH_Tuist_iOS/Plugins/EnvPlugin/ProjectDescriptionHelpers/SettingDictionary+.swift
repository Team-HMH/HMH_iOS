//
//  SettingDictionary+.swift
//  EnvPlugin
//
//  Created by 류희재 on 7/14/24.
//

import ProjectDescription

// 아직 여기의 필요성은 못 느끼는중 무슨 역할을 하게 될지 궁금하다!

public extension SettingsDictionary {
    // allLoadSettings와 baseSettings는 빌드 설정 딕셔너리의 기본값을 정의
    static let allLoadSettings: Self = [
        "OTHER_LDFLAGS" : [
            "$(inherited) -all_load",
            "-Xlinker -interposable"
        ]
    ]
    
    ///역할: Objective-C 카테고리 및 클래스를 정적으로 링크하도록 보장.
    ///사용 사례: Objective-C 기반 라이브러리를 사용할 때 기본적으로 필요.
    static let baseSettings: Self = [
        "OTHER_LDFLAGS" : [
            "$(inherited)",
            "-ObjC"
        ]
    ]
    
    ///번들 ID를 설정합니다.
    func setProductBundleIdentifier(_ value: String = "com.iOS$(BUNDLE_ID_SUFFIX)") -> SettingsDictionary {
        merging(["PRODUCT_BUNDLE_IDENTIFIER": SettingValue(stringLiteral: value)])
    }
    
    ///앱 아이콘 이름을 설정합니다.
    func setAssetcatalogCompilerAppIconName(_ value: String = "AppIcon$(BUNDLE_ID_SUFFIX)") -> SettingsDictionary {
        merging(["ASSETCATALOG_COMPILER_APPICON_NAME": SettingValue(stringLiteral: value)])
    }
    
    ///활성화된 아키텍처만 빌드할지 설정 (ONLY_ACTIVE_ARCH).
    func setBuildActiveArchitectureOnly(_ value: Bool) -> SettingsDictionary {
        merging(["ONLY_ACTIVE_ARCH": SettingValue(stringLiteral: value ? "YES" : "NO")])
    }
    
    ///특정 SDK에서 제외할 아키텍처를 설정 (EXCLUDED_ARCHS).
    func setExcludedArchitectures(sdk: String = "iphonesimulator*", _ value: String = "arm64") -> SettingsDictionary {
        merging(["EXCLUDED_ARCHS[sdk=\(sdk)]": SettingValue(stringLiteral: value)])
    }
    
    ///Swift 활성 컴파일 조건을 설정 (SWIFT_ACTIVE_COMPILATION_CONDITIONS).
    func setSwiftActiveComplationConditions(_ value: String) -> SettingsDictionary {
        merging(["SWIFT_ACTIVE_COMPILATION_CONDITIONS": SettingValue(stringLiteral: value)])
    }
    
    ///사용자 경로를 항상 검색할지 설정 (ALWAYS_SEARCH_USER_PATHS).
    func setAlwaysSearchUserPath(_ value: String = "NO") -> SettingsDictionary {
        merging(["ALWAYS_SEARCH_USER_PATHS": SettingValue(stringLiteral: value)])
    }
    
    ///복사 과정에서 디버그 심볼 제거 여부를 설정 (COPY_PHASE_STRIP).
    func setStripDebugSymbolsDuringCopy(_ value: String = "NO") -> SettingsDictionary {
        merging(["COPY_PHASE_STRIP": SettingValue(stringLiteral: value)])
    }
    
    ///동적 라이브러리 기본 설치 경로 설정 (DYLIB_INSTALL_NAME_BASE).
    func setDynamicLibraryInstallNameBase(_ value: String = "@rpath") -> SettingsDictionary {
        merging(["DYLIB_INSTALL_NAME_BASE": SettingValue(stringLiteral: value)])
    }
    
    ///설치 대상 여부를 설정 (SKIP_INSTALL).
    func setSkipInstall(_ value: Bool = false) -> SettingsDictionary {
        merging(["SKIP_INSTALL": SettingValue(stringLiteral: value ? "YES" : "NO")])
    }
    
    ///코드 서명을 수동으로 설정합니다.
    func setCodeSignManual() -> SettingsDictionary {
        merging(["CODE_SIGN_STYLE": SettingValue(stringLiteral: "Manual")])
            .merging(["DEVELOPMENT_TEAM": SettingValue(stringLiteral: "9K86FQHDLU")])
            .merging(["CODE_SIGN_IDENTITY": SettingValue(stringLiteral: "$(CODE_SIGN_IDENTITY)")])
    }
    
    ///프로비저닝 프로파일 설정.
    func setProvisioning() -> SettingsDictionary {
        merging(["PROVISIONING_PROFILE_SPECIFIER": SettingValue(stringLiteral: "$(APP_PROVISIONING_PROFILE)")])
            .merging(["PROVISIONING_PROFILE": SettingValue(stringLiteral: "$(APP_PROVISIONING_PROFILE)")])
    }
}

