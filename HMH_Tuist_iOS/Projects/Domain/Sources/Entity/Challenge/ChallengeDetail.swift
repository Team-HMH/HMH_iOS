//
//  ChallengeDetail.swift
//  Domain
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct ChallengeDetail {
    let statuses: [PointStatusEnum]
    let todayIndex: Int
    let startDate: String
    let challengeInfo: ChallengeInfo
    
    public enum InfoType {
        case period
        case goalTime
    }
    
    public init(statuses: [PointStatusEnum], todayIndex: Int, startDate: String, challengeInfo: ChallengeInfo) {
        self.statuses = statuses
        self.todayIndex = todayIndex
        self.startDate = startDate
        self.challengeInfo = challengeInfo
    }
    
    public func getTodayIndex() -> Int {
        return todayIndex
    }
    
    public func getStatuses() -> [PointStatusEnum] {
        return statuses
    }
    
    public func getStartDate() -> String {
        return startDate
    }
    
    public func getChallengeInfo(_ infoType: InfoType) -> Int {
        switch infoType {
        case .period:
            return challengeInfo.period
        case .goalTime:
            return challengeInfo.goalTime
        }
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
    
    public func getPeriod() -> Int {
        return period
    }
}
