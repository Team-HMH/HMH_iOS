//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 7/14/24.
//

//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2023/10/19.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "ThirdPartyLibs",
    targets: [.dynamicFramework],
    externalDependencies: [
        .SPM.Kingfisher,
        .SPM.Alamofire,
        .SPM.KakaoSDK,
        .SPM.KeychainAccess,
        .SPM.Moya,
        .SPM.Lottie
    ]
)

