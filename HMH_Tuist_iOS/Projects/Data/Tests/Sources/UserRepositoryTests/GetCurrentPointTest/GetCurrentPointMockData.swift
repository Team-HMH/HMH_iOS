//
//  GetCurrentPointMockData.swift
//  Data
//
//  Created by 류희재 on 11/5/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension PointResult {
    static public var expectedData: [Int] {
        return [100, 0 , -100, 200, 50, 10, 1000]
    }
}

extension PointResult {
    static public var resultData: [PointResult] {
        return [
            .init(point: 100),
            .init(point: 0),
            .init(point: -100),
            .init(point: 200),
            .init(point: 50),
            .init(point: 10),
            .init(point: 1000)
        ]
    }
}


