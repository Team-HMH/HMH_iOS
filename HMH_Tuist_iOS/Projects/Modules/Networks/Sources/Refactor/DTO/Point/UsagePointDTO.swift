//
//  UsagePointDTO.swift
//  Networks
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct UsagePointResult: Decodable {
    let usagePoint: Int
}

public extension UsagePointResult {
    static var stub: Self {
        return .init(usagePoint: 100)
    }
}

