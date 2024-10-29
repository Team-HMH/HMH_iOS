//
//  AppTransform.swift
//  Data
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Networks
import Domain

extension Apps {
    public func toEntity() -> AppInfo {
        return .init(
            appCode: appCode,
            goalTime: goalTime
        )
    }
}

extension AppInfo {
    public func toDTO() -> Apps {
        return .init(
            appCode: appCode,
            goalTime: goalTime
        )
    }
}
