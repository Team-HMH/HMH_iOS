//
//  getChallengeResponseDTO.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/16/24.
//

import Foundation

public struct GetChallengeResult: Decodable {
    public let period: Int
    public let statuses: [String]
    public let todayIndex: Int
    public let startDate: String
    public let goalTime: Int
    public let apps: [Apps]
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
