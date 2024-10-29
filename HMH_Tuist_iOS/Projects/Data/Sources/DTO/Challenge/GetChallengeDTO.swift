//
//  getChallengeResponseDTO.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/16/24.
//

import Foundation

public struct GetChallengeResult: Decodable {
    let period: Int
    let statuses: [String]
    let todayIndex: Int
    let startDate: String
    let goalTime: Int
    let apps: [Apps]
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
