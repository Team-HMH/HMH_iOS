//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 7/14/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "BaseFeatureDependency",
    targets: [.staticFramework],
    internalDependencies: [
        .domain,
        .Modules.dsKit,
        .HMHModules.deviceActivityMonitor,
        .HMHModules.hmhDeviceActivityReport,
        .HMHModules.shieldActionExtension,
        .HMHModules.shieldConfigureExtension
    ]
)
