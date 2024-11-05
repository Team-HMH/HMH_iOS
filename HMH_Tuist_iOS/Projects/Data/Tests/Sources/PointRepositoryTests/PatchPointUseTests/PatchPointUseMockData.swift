//
//  PatchPointUseMockData.swift
//  Data
//
//  Created by 류희재 on 11/5/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Domain
import Networks

extension UserPointInfo {
    static public var expectedData: [UserPointInfo] {
        return [
            .init(usagePoint: 100, remainPoint: 100),
            .init(usagePoint: 50, remainPoint: 150),
            .init(usagePoint: 200, remainPoint: 0),
            .init(usagePoint: 0, remainPoint: 200),
            .init(usagePoint: -100, remainPoint: 100),
            .init(usagePoint: 100, remainPoint: -100),
            .init(usagePoint: -100, remainPoint: -100),
        ]
    }
}

extension UsePointResult {
    static public var resultData: [UsePointResult] {
        return [
            .init(usagePoint: 100, userPoint: 100),
            .init(usagePoint: 50, userPoint: 150),
            .init(usagePoint: 200, userPoint: 0),
            .init(usagePoint: 0, userPoint: 200),
            .init(usagePoint: -100, userPoint: 100),
            .init(usagePoint: 100, userPoint: -100),
            .init(usagePoint: -100, userPoint: -100),
        ]
    }
}
