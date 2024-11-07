//
//  GetSuccesChallengeMockData.swift
//  Data
//
//  Created by 류희재 on 11/5/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension ChallengeSuccessResult {
    static public var expectedData: [[String]] {
        return [
            ["안녕", "안녕", "안녕", "안녕", "안녕", "안녕"],
            ["","","","",""],
            ["asdfasdfasdfasdf","asdfasdfasdfasdf","asdfasdfasdfasdf"]
        ]
    }
}

extension ChallengeSuccessResult {
    static public var resultData: [ChallengeSuccessResult] {
        return [
            .init(statuses: ["안녕", "안녕", "안녕", "안녕", "안녕", "안녕"]),
            .init(statuses: ["","","","",""]),
            .init(statuses: ["asdfasdfasdfasdf","asdfasdfasdfasdf","asdfasdfasdfasdf"])
        ]
    }
}


