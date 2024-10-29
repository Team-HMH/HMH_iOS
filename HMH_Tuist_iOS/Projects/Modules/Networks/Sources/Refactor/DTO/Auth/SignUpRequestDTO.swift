//
//  SignUpRequestDTO.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/14/24.
//

import Foundation

public struct SignUpRequestDTO: Codable {
    public let socialPlatform: String
    public let name: String
    public let onboarding: Onboarding
    public let challenge: Challenge
}

public struct Onboarding: Codable {
    let averageUseTime: String
    let problem: [String]
}

public struct Challenge: Codable {
    let period: Int
    let goalTime: Int
    let apps: [Apps]
}

public struct Apps: Codable {
    public let appCode: String
    public let goalTime: Int
    
    public init(appCode: String, goalTime: Int) {
        self.appCode = appCode
        self.goalTime = goalTime
    }
}

extension Apps {
    static var stub: Self {
        .init(appCode: "####", goalTime: 3)
    }
}
