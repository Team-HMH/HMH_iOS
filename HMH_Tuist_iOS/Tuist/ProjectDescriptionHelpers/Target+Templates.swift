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
        name: String,
        product: Product,
        platform: Platform = env.platform,
        bundleID: String,
        deploymentTarget: DeploymentTarget = env.deploymentTarget,
        infoPlist: InfoPlist?,
        sources: SourceFilesList,
        resources: ResourceFileElements? = nil,
        entitlements: Entitlements? = nil,
        dependencies: [TargetDependency] = []
    ) -> Target {
        .init(
            name: name,
            platform: platform,
            product: product,
            bundleId: bundleID,
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: .sources,
            resources: resources,
            entitlements: entitlements,
            dependencies: dependencies
        )
    }
}

extension TargetHandler {
    static func makeAppTarget(
        name: String,
        bundleSuffix: String,
        infoPlist: [String: Plist.Value],
        dependencies: [TargetDependency]
    ) -> Target {
        return TargetHandler.makeTarget(
            name: name,
            product: .app,
            bundleID: "\(env.bundlePrefix).\(bundleSuffix)",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: .sources,
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
            name: "\(name)Interface",
            product: .framework,
            bundleID: "\(env.bundlePrefix).\(name)Interface",
            infoPlist: .default,
            sources: .interface,
            dependencies: interfaceDependencies
        )
    }
    
    static func makeDemoTarget(name: String) -> Target {
        return TargetHandler.makeTarget(
            name: "\(name)Demo",
            product: .app,
            bundleID: "com.hmh.hamyeonham", //"\(env.bundlePrefix).\(name)Demo",
            infoPlist: .extendingDefault(with: Project.demoInfoPlist),
            sources: .demoSources,
            resources: [.glob(pattern: "Demo/Resources/**", excluding: ["Demo/Resources/dummy.txt"])],
            dependencies: [.target(name:name)]
        )
    }
    
    static func makeUnitTestTarget(name: String) -> Target {
        return TargetHandler.makeTarget(
            name: "\(name)Tests",
            product: .unitTests,
            bundleID: "\(env.bundlePrefix).\(name)Tests",
            infoPlist: .default,
            sources: .unitTests,
            dependencies: [.target(name: name)]
        )
    }
    
    static func makeFrameworkTarget(
        name: String,
        hasDynamicFramework: Bool,
        hasResources: Bool,
        dependencies: [TargetDependency]
    ) -> Target {
        return TargetHandler.makeTarget(
            name: name,
            product: hasDynamicFramework ? .framework : .staticFramework,
            bundleID: "\(env.bundlePrefix).\(name)",
            infoPlist: .default,
            sources: .sources,
            resources: hasResources ? [.glob(pattern: "Resources/**", excluding: [])] : [],
            dependencies: dependencies
        )
        
    }
}
