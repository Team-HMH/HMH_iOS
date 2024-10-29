//
//  EarnPointDTO.swift
//  Networks
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct EarnPointResult: Decodable {
    let earnPoint: Int
}

public extension EarnPointResult {
    static var stub: Self {
        return .init(earnPoint: 100)
    }
}
