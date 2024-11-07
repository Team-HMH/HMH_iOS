//
//  HomeChallengeDetailMapper.swift
//  Data
//
//  Created by 류희재 on 11/5/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Domain
import Networks

extension DailyChallengeResult {
    public func toEntity() -> DailyChallengeInfo {
        .init(
            status: status,
            goalTime: goalTime,
            apps: apps.map { $0.toEntity() }
        )
    }
}
