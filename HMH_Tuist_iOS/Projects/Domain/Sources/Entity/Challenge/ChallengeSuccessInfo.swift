//
//  DailyChallengeInfo.swift
//  Domain
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

public struct ChallengeSuccessInfo {
    let challengeDate: String
    let isSuccess: Bool
    
    public init(challengeDate: String, isSuccess: Bool) {
        self.challengeDate = challengeDate
        self.isSuccess = isSuccess
    }
}
