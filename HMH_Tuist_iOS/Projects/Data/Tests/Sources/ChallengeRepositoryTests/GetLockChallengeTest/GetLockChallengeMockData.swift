//
//  GetLockChallengeMockData.swift
//  Data
//
//  Created by 류희재 on 11/6/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension GetLockResult {
    static public var expectedData: [Bool] {
        return [true, false]
    }
}

extension GetLockResult {
    static public var resultData: [GetLockResult] {
        return [
            .init(isLockToday: true),
            .init(isLockToday: false)
        ]
    }
}
