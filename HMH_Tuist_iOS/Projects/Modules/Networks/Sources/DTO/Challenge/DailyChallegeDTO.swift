//
//  DailyChallegeDTO.swift
//  Networks
//
//  Created by 류희재 on 11/5/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct DailyChallengeResult: Decodable {
    public let status: String
    public let goalTime: Int
    public let apps: [AppInfoDTO]
    
    public init(status: String, goalTime: Int, apps: [AppInfoDTO]) {
        self.status = status
        self.goalTime = goalTime
        self.apps = apps
    }
}

public extension DailyChallengeResult {
    static var stub1: Self {
        .init(
            status: "1234",
            goalTime: 123434,
            apps: [.stub])
    }
}

