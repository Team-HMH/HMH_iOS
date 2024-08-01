//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 7/13/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

import ConfigPlugin

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/onevcat/Kingfisher", requirement: .upToNextMajor(from: "7.11.0")),
    .remote(url: "https://github.com/Moya/Moya", requirement: .upToNextMajor(from: "15.0.3")),
    .remote(url: "https://github.com/airbnb/lottie-ios", requirement: .upToNextMajor(from: "4.4.1")),
    .remote(url: "https://github.com/kakao/kakao-ios-sdk.git", requirement: .upToNextMajor(from: "2.0.0")),
    .remote(url: "https://github.com/kishikawakatsumi/KeychainAccess", requirement: .upToNextMajor(from: "4.2.2"))
    
], baseSettings: Settings.settings(
    configurations: XCConfig.framework
))

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)

