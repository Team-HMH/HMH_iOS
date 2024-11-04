//
//  DailyChallengeTransform.swift
//  Data
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension FinishedDailyChallenge {
    func toEntity() -> DailyChallengeInfo {
        return .init(challengeDate: challengeDate, isSuccess: isSuccess)
    }
}
