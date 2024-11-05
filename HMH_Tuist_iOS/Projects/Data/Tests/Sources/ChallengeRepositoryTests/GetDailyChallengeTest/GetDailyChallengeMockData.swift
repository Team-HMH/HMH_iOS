//
//  GetDailyChallengeMockData.swift
//  Data
//
//  Created by 류희재 on 11/5/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension DailyChallengeInfo {
    static public var expectedData: DailyChallengeInfo {
        return .init(
            status: "NONE",
            goalTime: 7200000,
            apps: [.init(appCode: "#292043", goalTime: 3200000)]
        )
    }
}

extension DailyChallengeResult {
    static public var resultData: DailyChallengeResult {
        return .init(
            status: "NONE",
            goalTime: 7200000,
            apps: [.init(appCode: "#292043", goalTime: 3200000)]
        )
    }
}
