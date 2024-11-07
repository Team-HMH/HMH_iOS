//
//  HomeChallengeDetail.swift
//  Domain
//
//  Created by 류희재 on 11/5/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

public struct DailyChallengeInfo: Equatable {
    public let status: String
    public let goalTime: Int
    public let apps: [AppInfo]
    
    public init(status: String, goalTime: Int, apps: [AppInfo]) {
        self.status = status
        self.goalTime = goalTime
        self.apps = apps
    }
}
