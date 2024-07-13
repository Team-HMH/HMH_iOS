//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 7/14/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

//TODO: SPM 등록하기 
let project = Project.makeModule(
    name: "ThirdPartyLibs",
    targets: [.dynamicFramework],
    externalDependencies: [
//        .SPM.SnapKit,
//        .SPM.Then,
//        .SPM.RxGesture,
//        .SPM.Kingfisher,
//        .SPM.RxCocoa,
//        .SPM.RxDataSources,
//        .SPM.RxRelay,
//        .SPM.RxSwift,
//        .SPM.ReactorKit
    ]
)
