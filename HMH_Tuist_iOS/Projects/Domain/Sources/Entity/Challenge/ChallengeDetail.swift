//
//  ChallengeDetail.swift
//  Domain
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct ChallengeDetail {
    let period: Int
    let statuses: [String]
    let todayIndex: Int
    let startDate: String
    let goalTime: Int
    let apps: [AppInfo]
    
    public init(period: Int, statuses: [String], todayIndex: Int, startDate: String, goalTime: Int, apps: [AppInfo]) {
        self.period = period
        self.statuses = statuses
        self.todayIndex = todayIndex
        self.startDate = startDate
        self.goalTime = goalTime
        self.apps = apps
    }
}
