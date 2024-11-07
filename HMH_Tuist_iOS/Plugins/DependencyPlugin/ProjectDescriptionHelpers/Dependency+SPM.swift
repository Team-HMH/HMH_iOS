//
//  Dependency+SPM.swift
//  MyPlugin
//
//  Created by 류희재 on 7/13/24.
//

import ProjectDescription

/// TargetDependency의 확장을 통해
/// 프로젝트 내 외부 라이브러리 종속성을 보다 체계적으로 관리하기 위한 유틸리티를 제공하는 파일

public extension TargetDependency {
    enum SPM {}
    enum Carthage {}
}

public extension TargetDependency.SPM {
    static let Lottie = TargetDependency.external(name: "Lottie")
    static let KakaoSDK = TargetDependency.external(name: "KakaoSDK")
    static let KeychainAccess = TargetDependency.external(name: "KeychainAccess")
}

