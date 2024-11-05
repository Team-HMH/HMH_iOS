//
//  GetUsagePointResultMockData.swift
//  Data
//
//  Created by 류희재 on 11/5/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Domain
import Networks

extension UsagePointResult {
    static public var expectedData: [Int] {
        return [100, 0 , -100, 200, 50, 10, 1000]
    }
    
    static public var resultData: [UsagePointResult] {
        return [
            .init(usagePoint: 100),
            .init(usagePoint: 0),
            .init(usagePoint: -100),
            .init(usagePoint: 200),
            .init(usagePoint: 50),
            .init(usagePoint: 10),
            .init(usagePoint: 1000)
        ]
    }
}

