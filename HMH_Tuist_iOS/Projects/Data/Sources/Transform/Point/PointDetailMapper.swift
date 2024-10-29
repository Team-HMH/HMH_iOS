//
//  PointDetailInfo.swift
//  Data
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension PointListResult {
    func toEntity() -> PointDetail {
        .init(
            point: period,
            period: period,
            pointStatuses: challengePointStatuses.map { $0.toEntity() }
        )
    }
}

extension ChallengePointStatuses {
    func toEntity() -> PointStatuse {
        .init(date: challengeDate, status: status)
    }
}
