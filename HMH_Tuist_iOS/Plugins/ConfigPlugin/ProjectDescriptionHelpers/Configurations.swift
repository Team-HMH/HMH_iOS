//
//  Configurations.swift
//  MyPlugin
//
//  Created by 류희재 on 7/13/24.
//

import Foundation
import ProjectDescription

/// 빌드할 환경에 대한 설정

/// Target 분리 (The Modular Architecture 기반으로 분리했습니다)


/// DEV : 실제 프로덕트 BaseURL을 사용하는 debug scheme
/// TEST : 테스트 BaseURL을 사용하는 debug scheme
/// QA : 테스트 BaseURL을 사용하는 release scheme
/// RELEASE : 실제 프로덕트 BaseURL을 사용하는 release scheme
///
/// -> 이부분에서 두개의 Config 파일
/// 1) DEV, RELEASE -> 실제 BaseURL
/// 2) TEST, QA -> 테스트 BaseURL


public struct XCConfig {
    private struct Path {
        static var framework: ProjectDescription.Path { .relativeToRoot("Configurations/Targets/iOS-Framework.xcconfig") }
        static var demo: ProjectDescription.Path { .relativeToRoot("Configurations/Targets/iOS-Demo.xcconfig") }
        static var tests: ProjectDescription.Path { .relativeToRoot("Configurations/Targets/iOS-Tests.xcconfig") }
        static func project(_ config: String) -> ProjectDescription.Path { .relativeToRoot("Configurations/Base/Projects/Project-\(config).xcconfig") }
    }
    
    public static let framework: [Configuration] = [
        .debug(name: "Development", xcconfig: Path.framework),
        .debug(name: "Test", xcconfig: Path.framework),
        .release(name: "QA", xcconfig: Path.framework),
        .release(name: "PROD", xcconfig: Path.framework),
    ]
    
    public static let tests: [Configuration] = [
        .debug(name: "Development", xcconfig: Path.tests),
        .debug(name: "Test", xcconfig: Path.tests),
        .release(name: "QA", xcconfig: Path.tests),
        .release(name: "PROD", xcconfig: Path.tests),
    ]
    public static let demo: [Configuration] = [
        .debug(name: "Development", xcconfig: Path.demo),
        .debug(name: "Test", xcconfig: Path.demo),
        .release(name: "QA", xcconfig: Path.demo),
        .release(name: "PROD", xcconfig: Path.demo),
    ]
    public static let project: [Configuration] = [
        .debug(name: "Development", xcconfig: Path.project("Development")),
        .debug(name: "Test", xcconfig: Path.project("Test")),
        .release(name: "QA", xcconfig: Path.project("QA")),
        .release(name: "PROD", xcconfig: Path.project("PROD")),
    ]
}

