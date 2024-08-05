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
    /// DEV : 실제 프로덕트 BaseURL을 사용하는 debug scheme
    /// TEST : 테스트 BaseURL을 사용하는 debug scheme
    /// QA : 테스트 BaseURL을 사용하는 release scheme
    /// RELEASE : 실제 프로덕트 BaseURL을 사용하는 release scheme

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



