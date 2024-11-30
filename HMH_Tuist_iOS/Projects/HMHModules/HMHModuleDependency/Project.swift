//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 11/28/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "HMHModuleDependency",
    targets: [.dynamicFramework],
    internalDependencies: [
        .Modules.dsKit,
        .core
    ]
)

