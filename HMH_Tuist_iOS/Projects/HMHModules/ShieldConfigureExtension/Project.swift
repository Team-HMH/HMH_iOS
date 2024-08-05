//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 7/30/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import EnvPlugin

let project = Project.makeModule(
    name: "ShieldConfigureExtension",
    targets: [.dynamicFramework],
    internalDependencies: [
        .Modules.dsKit
    ]
)
