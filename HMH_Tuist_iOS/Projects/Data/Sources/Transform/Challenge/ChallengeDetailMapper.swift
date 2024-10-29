//
//  ChallengeDetailTransform.swift
//  Data
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension GetChallengeResult {
    public func toEntity() -> ChallengeDetail {
        .init(
            statuses: statuses,
            todayIndex: todayIndex,
            startDate: startDate,
            challengeInfo: .init(
                period: period,
                goalTime: goalTime,
                apps: apps.map { $0.toEntity() }
            )
        )
    }
}

extension ChallengeInfo {
    public func toDTO() -> ChallengeRequest {
        .init(
            period: period,
            goalTime: goalTime,
            apps: apps.map {$0.toDTO()
            }
        )
    }
}
