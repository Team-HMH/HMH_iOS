//
//  Midnight.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/16/24.
//

import Foundation

public struct ChallengeSuccessResult: Decodable {
    let finishedDailyChallenges: [FinishedDailyChallenge]
}

struct FinishedDailyChallenge: Decodable {
    let challengeDate: String
    let isSuccess: Bool
}
