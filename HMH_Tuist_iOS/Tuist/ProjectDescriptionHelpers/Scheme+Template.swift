//
//  Scheme+Template.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 7/13/24.
//

import ProjectDescription
import EnvPlugin

extension Scheme {
    /// Scheme 생성하는 method
    /// 어떤 타겟을 빌드할 것인지, 어떤 테스트를 실행할 것인지 또한 어떤 환경에서 빌드할 것인지 설정
    ///
    /// DEV :  테스트 BaseURL을 사용하는 debug scheme
    /// PROD : 실제 프로덕트 BaseURL을 사용하는 release scheme
    static let appSchemes: [Scheme] = [
        /*
         name: 스킴의 이름을 정의
         shared: 이 스킴을 다른 사용자와 공유할지 여부를 설정
         testAction: 테스트 실행 시 사용할 타겟과 설정을 정의
            파라미터:
            - targets: 테스트에 포함할 타겟 배열.
            - configuration: 테스트 실행에 사용할 빌드 구성(Debug, Release 등).
            - options: 테스트 실행 시 추가 옵션.
            - coverage: 코드 커버리지 측정 활성화 여부.
            - codeCoverageTargets: 코드 커버리지를 추적할 대상 타겟.
         runAction: 실행(run) 시 사용할 빌드 구성을 정의
            - configuration: 실행 시 사용할 빌드 구성(Debug, Release, Development 등).
         archiveAction: 아카이브 생성 시 사용할 빌드 구성을 정의
            - configuration: 아카이브 생성 시 사용할 빌드 구성.
         profileAction: 프로파일링(성능 분석) 시 사용할 빌드 구성을 정의
            - configuration: 아카이브 생성 시 사용할 빌드 구성.
         analyzeAction: 정적 코드 분석(Analyze) 시 사용할 빌드 구성
            - configuration: 정적 코드 분석 시 사용할 빌드 구성.
         */

        // Test API, debug scheme : 실제 프로덕트 BaseURL을 사용하는 debug scheme
        .init(
            name: "\(env.workspaceName)-DEV",
            shared: true,
            buildAction: .buildAction(targets: ["\(env.workspaceName)"]),
            testAction: .targets(
                ["\(env.workspaceName)Tests", "\(env.workspaceName)UITests"],
                configuration: "Development",
                options: .options(coverage: true, codeCoverageTargets: ["\(env.workspaceName)"])
            ),
            runAction: .runAction(configuration: "Development"),
            archiveAction: .archiveAction(configuration: "Development"),
            profileAction: .profileAction(configuration: "Development"),
            analyzeAction: .analyzeAction(configuration: "Development")
        ),
        // PROD API, release scheme : 실제 프로덕트 BaseURL을 사용하는 release scheme
        .init(
            name: "\(env.workspaceName)-PROD",
            shared: true,
            buildAction: .buildAction(targets: ["\(env.workspaceName)"]),
            runAction: .runAction(configuration: "PROD"),
            archiveAction: .archiveAction(configuration: "PROD"),
            profileAction: .profileAction(configuration: "PROD"),
            analyzeAction: .analyzeAction(configuration: "PROD")
        ),
        // Test API, debug scheme, Demo App Target
        .makeDemoAppTestScheme()
    ]

    static func makeScheme(configs: ConfigurationName, name: String) -> Scheme { // 일반앱
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: configs,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: configs),
            archiveAction: .archiveAction(configuration: configs),
            profileAction: .profileAction(configuration: configs),
            analyzeAction: .analyzeAction(configuration: configs)
        )
    }

    static func makeDemoScheme(configs: ConfigurationName, name: String) -> Scheme { // 데모앱
        return Scheme(
            name: "\(name)Demo",
            shared: true,
            buildAction: .buildAction(targets: ["\(name)Demo"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: configs,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)Demo"])
            ),
            runAction: .runAction(configuration: configs),
            archiveAction: .archiveAction(configuration: configs),
            profileAction: .profileAction(configuration: configs),
            analyzeAction: .analyzeAction(configuration: configs)
        )
    }

    static func makeDemoAppTestScheme() -> Scheme { // 데모테스트앱
        let targetName = "\(env.workspaceName)-Demo"
        return Scheme(
          name: "\(targetName)-Test",
          shared: true,
          buildAction: .buildAction(targets: ["\(targetName)"]),
          testAction: .targets(
              ["\(targetName)Tests"],
              configuration: "Test",
              options: .options(coverage: true, codeCoverageTargets: ["\(targetName)"])
          ),
          runAction: .runAction(configuration: "Test"),
          archiveAction: .archiveAction(configuration: "Test"),
          profileAction: .profileAction(configuration: "Test"),
          analyzeAction: .analyzeAction(configuration: "Test")
        )
    }
}



