//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 7/16/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

//TODO: 나머지 4개의 모듈 여기로 주입
let project = Project.makeModule(
    name: "ChallengeFeature",
    targets: [.staticFramework, .demo, .interface],
    interfaceDependencies: [
        .Features.BaseFeatureDependency
    ]
)
