//
//  PatchEarnPointMockData.swift
//  Data
//
//  Created by 류희재 on 11/5/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Domain
import Networks

extension UserPointResult {
    static public var expectedData: [Int] {
        return [100, 0 , -100, 200, 50, 10, 1000]
    }
    
    static public var resultData: [UserPointResult] {
        return [
            .init(userPoint: 100),
            .init(userPoint: 00),
            .init(userPoint: -100),
            .init(userPoint: 200),
            .init(userPoint: 50),
            .init(userPoint: 10),
            .init(userPoint: 1000)
        ]
    }
}


