//
//  Target+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 11/20/24.
//

import Foundation
import ProjectDescription

import EnvPlugin

struct TargetHandler {
    static func makeTarget(
        targetType: FeatureTarget,
        name: String,
        platform: Platform = env.platform,
        bundleID: String,
        deploymentTarget: DeploymentTarget = env.deploymentTarget,
        infoPlist: InfoPlist = .default,
        resources: ResourceFileElements? = nil,
        entitlements: Entitlements? = nil,
        dependencies: [TargetDependency] = []
    ) -> Target {
        .init(
            name: name,
            platform: platform,
            product: targetType.product,
            bundleId: bundleID,
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: targetType.sources,
            resources: resources,
            entitlements: entitlements,
            dependencies: dependencies
        )
    }
}

extension TargetHandler {
    static func makeAppTarget(
        name: String,
        dependencies: [TargetDependency]
    ) -> Target {
        return TargetHandler.makeTarget(
            targetType: .app,
            name: name,
            bundleID: "\(env.bundlePrefix).\(name.contains("Demo") ? "test" : "release")",
            infoPlist: InfoPlistProvider.forApp(name: name),
            resources: [.glob(pattern: "Resources/**", excluding: [])],
            entitlements: "\(name).entitlements",
            dependencies: dependencies
        )
    }
    
    static func makeInterfaceTarget(
        name: String,
        interfaceDependencies: [TargetDependency]
    ) -> Target {
        return TargetHandler.makeTarget(
            targetType: .interface,
            name: "\(name)Interface",
            bundleID: "\(env.bundlePrefix).\(name)Interface",
            dependencies: interfaceDependencies
        )
    }
    
    static func makeDemoTarget(name: String) -> Target {
        return TargetHandler.makeTarget(
            targetType: .demo,
            name: "\(name)Demo",
            bundleID: "com.hmh.hamyeonham", //"\(env.bundlePrefix).\(name)Demo",
            infoPlist: .extendingDefault(with: Project.demoInfoPlist),
            resources: [.glob(pattern: "Demo/Resources/**", excluding: ["Demo/Resources/dummy.txt"])],
            dependencies: [.target(name:name)]
        )
    }
    
    static func makeUnitTestTarget(name: String) -> Target {
        return TargetHandler.makeTarget(
            targetType: .unitTest,
            name: "\(name)Tests",
            bundleID: "\(env.bundlePrefix).\(name)Tests",
            dependencies: [.target(name: name)]
        )
    }
    
    static func makeStaticFrameworkTarget(
        name: String,
        hasResources: Bool,
        dependencies: [TargetDependency]
    ) -> Target {
        return TargetHandler.makeTarget(
            targetType: .staticFramework,
            name: name,
            bundleID: "\(env.bundlePrefix).\(name)",
            resources: hasResources ? [.glob(pattern: "Resources/**", excluding: [])] : [],
            dependencies: dependencies
        )
    }
    
    static func makeDynamicFrameworkTarget(
        name: String,
        hasResources: Bool,
        dependencies: [TargetDependency]
    ) -> Target {
        return TargetHandler.makeTarget(
            targetType: .dynamicFramework,
            name: name,
            bundleID: "\(env.bundlePrefix).\(name)",
            resources: hasResources ? [.glob(pattern: "Resources/**", excluding: [])] : [],
            dependencies: dependencies
        )
    }
}
