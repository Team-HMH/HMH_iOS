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
        return .init(
            period: self.period,
            statuses: self.statuses,
            todayIndex: self.todayIndex,
            startDate: self.startDate,
            goalTime: self.goalTime,
            apps: self.apps.map { $0.toEntity() }
        )
    }
}
