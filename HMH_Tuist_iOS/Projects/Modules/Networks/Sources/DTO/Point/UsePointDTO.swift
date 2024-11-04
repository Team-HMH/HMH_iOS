//
//  UsePointDTO.swift
//  Networks
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct UsePointResult: Decodable {
    public let usagePoint: Int
    public let userPoint: Int
}

public extension UsePointResult {
    static var stub: Self {
        return .init(usagePoint: 100, userPoint: 100)
    }
}
