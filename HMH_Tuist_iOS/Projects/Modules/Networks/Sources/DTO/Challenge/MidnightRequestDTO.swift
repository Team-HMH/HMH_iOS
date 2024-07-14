//
//  Midnight.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/16/24.
//

import Foundation

struct MidnightRequestDTO: Codable {
    let finishedDailyChallenges: [FinishedDailyChallenge]
}

// MARK: - FinishedDailyChallenge
struct FinishedDailyChallenge: Codable {
    let challengeDate: String
    let isSuccess: Bool
}
