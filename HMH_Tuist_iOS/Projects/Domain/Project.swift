//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 7/14/24.
//

import Foundation

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "Domain",
    targets: [.dynamicFramework],
    internalDependencies: [
        .core,
        .Modules.dsKit
    ]
)
