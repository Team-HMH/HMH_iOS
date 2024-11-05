//
//  UserPointInfo.swift
//  Data
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension UsePointResult {
    func toEntity() -> UserPointInfo {
        .init(
            usagePoint: usagePoint,
            remainPoint: userPoint
        )
    }
}

extension UserPointInfo {
    func toDTO() -> UsePointResult {
        return .init(
            usagePoint: usagePoint,
            userPoint: remainPoint
        )
    }
}
