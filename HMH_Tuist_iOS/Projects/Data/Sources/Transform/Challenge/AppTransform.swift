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
    public func toEntity() -> App {
        return .init(
            appCode: self.appCode,
            goalTime: self.goalTime
        )
    }
}

extension App {
    public func toDTO() -> Apps {
        return .init(
            appCode: self.appCode,
            goalTime: self.goalTime
        )
    }
}
