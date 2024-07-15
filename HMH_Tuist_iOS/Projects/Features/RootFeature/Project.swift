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
    name: "RootFeature",
    targets: [.staticFramework, .demo],
    internalDependencies: [
        .Features.Login.Feature,
        .Features.Onboarding.Feature,
        .Features.MyPage.Feature,
        .Features.Home.Feature,
        .Features.Challenge.Feature
    ]
)
