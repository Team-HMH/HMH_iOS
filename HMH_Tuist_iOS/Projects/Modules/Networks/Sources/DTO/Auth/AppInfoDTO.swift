//
//  AppInfoDTO.swift
//  Networks
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct AppInfoDTO: Codable {
    public let appCode: String
    public let goalTime: Int
    
    public init(appCode: String, goalTime: Int) {
        self.appCode = appCode
        self.goalTime = goalTime
    }
}

public extension AppInfoDTO {
    static var stub: Self {
        .init(appCode: "#25393", goalTime: 1204928)
    }
}

