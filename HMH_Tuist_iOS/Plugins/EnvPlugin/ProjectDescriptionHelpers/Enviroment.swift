//
//  Enviroment.swift
//  MyPlugin
//
//  Created by 류희재 on 7/13/24.
//

import ProjectDescription

/// 프로젝트 환경 관련 파일입니다

public struct ProjectEnvironment {
    public let workspaceName: String
    public let deploymentTarget: DeploymentTarget
    public let platform: Platform
    public let bundlePrefix: String
}

//TODO: 추후 환경에 맞게 변경해야 합니다. 다시 한번 체크하기
public let env = ProjectEnvironment(
    workspaceName: "HMH-iOS",
    deploymentTarget: DeploymentTarget.iOS(targetVersion: "17.0", devices: [.iphone]),
    platform: .iOS,
    bundlePrefix: "com.HMH-iOS"
)

