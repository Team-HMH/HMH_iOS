//
//  Midnight.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/16/24.
//

import Foundation

public struct ChallengeSuccessRequest: Encodable {
    let finishedDailyChallenges: [FinishedDailyChallenge]
    
    public init(finishedDailyChallenges: [FinishedDailyChallenge]) {
        self.finishedDailyChallenges = finishedDailyChallenges
    }
}

public struct FinishedDailyChallenge: Encodable {
    public let challengeDate: String
    public let isSuccess: Bool
    
    public init(challengeDate: String, isSuccess: Bool) {
        self.challengeDate = challengeDate
        self.isSuccess = isSuccess
    }
}

public struct ChallengeSuccessResult: Decodable {
    public let statuses: [String]
    
    public init(statuses: [String]) {
        self.statuses = statuses
    }
}

public extension ChallengeSuccessResult {
    static var stub: Self {
        .init(statuses: ["dkdk", "dkdk", "dkdk"])
    }
}
