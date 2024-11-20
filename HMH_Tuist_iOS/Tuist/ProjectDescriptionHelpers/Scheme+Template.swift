//
//  Scheme+Template.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 7/13/24.
//

import ProjectDescription
import EnvPlugin

struct SchemeProvider {
    static func makeProjectScheme(targets: Set<FeatureTarget>, name: String) -> [Scheme] {
        if targets.contains(.app) {
            return Scheme.appSchemes
        } else {
            var scheme: [Scheme] = [Scheme.makeScheme(name: name)]
            if targets.contains(.demo) { scheme.append(Scheme.makeDemoScheme(name: name))}
            return scheme
        }
    }
}

extension Scheme {
    static let appSchemes: [Scheme] = [
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
        .init(
            name: "\(env.workspaceName)-PROD",
            shared: true,
            buildAction: .buildAction(targets: ["\(env.workspaceName)"]),
            runAction: .runAction(configuration: "PROD"),
            archiveAction: .archiveAction(configuration: "PROD"),
            profileAction: .profileAction(configuration: "PROD"),
            analyzeAction: .analyzeAction(configuration: "PROD")
        ),
    ]
    
    // makeDemoScheme은 실제 앱이 아니기 때문에 그냥 Dev상황만 반영한다.
    static func makeDemoScheme(name: String) -> Scheme { // 데모앱
            return Scheme(
                name: "\(name)Demo",
                shared: true,
                buildAction: .buildAction(targets: ["\(name)Demo"]),
                testAction: .targets(
                    ["\(name)Tests"],
                    configuration: "Development",
                    options: .options(coverage: true, codeCoverageTargets: ["\(name)Demo"])
                ),
                runAction: .runAction(configuration: "Development"),
                archiveAction: .archiveAction(configuration: "Development"),
                profileAction: .profileAction(configuration: "Development"),
                analyzeAction: .analyzeAction(configuration: "Development")
            )
        }

    // makeScheme은 실제 앱이 아니기 때문에 그냥 Dev상황만 반영한다.
    static func makeScheme(name: String) -> Scheme { // 일반앱
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: "Development",
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: "Development"),
            archiveAction: .archiveAction(configuration: "Development"),
            profileAction: .profileAction(configuration: "Development"),
            analyzeAction: .analyzeAction(configuration: "Development")
        )
    }
}



