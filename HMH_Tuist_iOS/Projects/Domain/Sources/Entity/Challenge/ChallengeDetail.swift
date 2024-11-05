//
//  ChallengeDetail.swift
//  Domain
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

@frozen public enum ChallengeStatus: String {
    case EARNED
    case FAILURE
    case UNEARNED
}

public struct ChallengeDetail: Equatable {
    let statuses: [String]
    let todayIndex: Int
    let startDate: String
    let challengeInfo: ChallengeInfo
    
    public init(statuses: [String], todayIndex: Int, startDate: String, challengeInfo: ChallengeInfo) {
        self.statuses = statuses
        self.todayIndex = todayIndex
        self.startDate = startDate
        self.challengeInfo = challengeInfo
    }
}

public struct ChallengeInfo: Equatable {
    public let period: Int
    public let goalTime: Int
    public let apps: [AppInfo]
    
    public init(period: Int, goalTime: Int, apps: [AppInfo]) {
        self.period = period
        self.goalTime = goalTime
        self.apps = apps
    }
}
