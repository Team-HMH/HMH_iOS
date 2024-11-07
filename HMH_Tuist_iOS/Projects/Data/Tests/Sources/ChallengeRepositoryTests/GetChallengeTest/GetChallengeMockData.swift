//
//  GetChallengeMockData.swift
//  Data
//
//  Created by 류희재 on 11/5/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Networks
import Domain

extension ChallengeDetail  {
    static public var expectedData: ChallengeDetail {
        .init(
            statuses: [
                "UNEARNED",
                "UNEARNED",
                "NONE",
                "NONE",
                "NONE",
                "NONE",
                "NONE"
            ],
            todayIndex: 2,
            startDate: "2024-05-17",
            challengeInfo: ChallengeInfo(
                period: 7,
                goalTime: 7200000,
                apps: [
                    .init(appCode: "#292043", goalTime: 12312420),
                    .init(appCode: "#693043", goalTime: 12312420)
                ]
            )
        )
    }
}

extension GetChallengeResult {
    static public var resultData: GetChallengeResult {
        return .init(
            period: 7,
            statuses: [
                "UNEARNED",
                "UNEARNED",
                "NONE",
                "NONE",
                "NONE",
                "NONE",
                "NONE"
            ],
            todayIndex: 2,
            startDate: "2024-05-17",
            goalTime: 7200000,
            apps: [
                .init(appCode: "#292043", goalTime: 12312420),
                .init(appCode: "#693043", goalTime: 12312420)
            ]
        )
    }
}
