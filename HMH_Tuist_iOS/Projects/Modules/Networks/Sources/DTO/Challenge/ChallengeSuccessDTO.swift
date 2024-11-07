//
//  Midnight.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/16/24.
//

import Foundation

public struct ChallengeSuccessRequest: Encodable {
    let finishedDailyChallenges: [FinishedDailyChallenge]
}

public struct FinishedDailyChallenge: Encodable {
    public let challengeDate: String
    public let isSuccess: Bool
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
