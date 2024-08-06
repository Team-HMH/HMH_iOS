//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 7/14/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import EnvPlugin

let project = Project.makeModule(
    name: env.workspaceName,
    targets: [.app],
    internalDependencies: [
//        .data, //현재 너무 역할이 애매함으로 Network 모듈로 수정해둠
        .Modules.networks,
        .Features.RootFeature
    ]
)

