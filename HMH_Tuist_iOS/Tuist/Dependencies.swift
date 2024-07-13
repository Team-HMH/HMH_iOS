//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 7/13/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

import ConfigPlugin

//TODO: SPM에 맞게 해당 부분 세팅하기
let spm = SwiftPackageManagerDependencies([
//    .remote(url: "https://github.com/SnapKit/SnapKit", requirement: .upToNextMinor(from: "5.0.0")),
//    .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "2")),
//    .remote(url: "https://github.com/onevcat/Kingfisher", requirement: .upToNextMajor(from: "7.6.2")),
//    .remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .upToNextMajor(from: "6.6.0")),
//    .remote(url: "https://github.com/RxSwiftCommunity/RxGesture", requirement: .upToNextMajor(from: "4.0.4")),
//    .remote(url: "https://github.com/RxSwiftCommunity/RxDataSources", requirement: .upToNextMajor(from: "5.0.2")),
//    .remote(url: "https://github.com/ReactorKit/ReactorKit", requirement: .upToNextMajor(from: "3.0.0"))
], baseSettings: Settings.settings(
    configurations: XCConfig.framework
))

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)

