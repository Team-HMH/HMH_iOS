//
//  getChallengeResponseDTO.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/16/24.
//

import Foundation

public struct GetChallengeResult: Decodable {
    public init(period: Int, statuses: [String], todayIndex: Int, startDate: String, goalTime: Int, apps: [AppInfoDTO]) {
        self.period = period
        self.statuses = statuses
        self.todayIndex = todayIndex
        self.startDate = startDate
        self.goalTime = goalTime
        self.apps = apps
    }
    public let period: Int
    public let statuses: [String]
    public let todayIndex: Int
    public let startDate: String
    public let goalTime: Int
    public let apps: [AppInfoDTO]
}

public extension GetChallengeResult {
    static var stub1: Self {
        .init(
            period: 1,
            statuses: ["stub"],
            todayIndex: 1,
            startDate: "dkdkd",
            goalTime: 12,
            apps: [.stub, .stub, .stub])
    }
}
