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
    name: "Data",
    targets: [.staticFramework, .demo],
    internalDependencies: [
        .domain,
        .Modules.networks
    ]
)
