//
//  GetEarnPointMockData.swift
//  Data
//
//  Created by 류희재 on 11/5/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Domain
import Networks

extension EarnPointResult {
    static public var expectedData: [Int] {
        return [100, 0 , -100, 200, 50, 10, 1000]
    }
    
    static public var resultData: [EarnPointResult] {
        return [
            .init(earnPoint: 100),
            .init(earnPoint: 0),
            .init(earnPoint: -100),
            .init(earnPoint: 200),
            .init(earnPoint: 50),
            .init(earnPoint: 10),
            .init(earnPoint: 1000)
        ]
    }
}

