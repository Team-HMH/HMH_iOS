//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 7/16/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "HomeFeature",
    targets: [.staticFramework, .demo],
    internalDependencies: [
        .Features.BaseFeatureDependency
    ]
)
