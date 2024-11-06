//
//  GetPointListMockData.swift
//  Data
//
//  Created by 류희재 on 11/5/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Domain
import Networks

extension PointDetail {
    static public var expectedData: [PointDetail] {
        return [
            .init(point: 100, period: 100, pointStatuses: [.stub]),
            .init(point: 100, period: 100, pointStatuses: [.stub]),
            .init(point: 100, period: 100, pointStatuses: [.stub]),
            .init(point: 100, period: 100, pointStatuses: [.stub]),
            .init(point: 100, period: 100, pointStatuses: [.stub]),
            .init(point: 100, period: 100, pointStatuses: [.stub]),
            .init(point: 100, period: 100, pointStatuses: [.stub])
        ]
    }
}

extension PointListResult {
    static public var resultData: [PointListResult] {
        return [
            .init(point: 100, period: 100, challengePointStatuses: [.stub]),
            .init(point: 100, period: 100, challengePointStatuses: [.stub]),
            .init(point: 100, period: 100, challengePointStatuses: [.stub]),
            .init(point: 100, period: 100, challengePointStatuses: [.stub]),
            .init(point: 100, period: 100, challengePointStatuses: [.stub]),
            .init(point: 100, period: 100, challengePointStatuses: [.stub]),
            .init(point: 100, period: 100, challengePointStatuses: [.stub])
        ]
    }
}
