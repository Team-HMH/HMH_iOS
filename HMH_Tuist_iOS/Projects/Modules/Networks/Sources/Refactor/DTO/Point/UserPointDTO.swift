//
//  UserPoint.swift
//  Networks
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

struct UserPointRequest: Encodable {
    let challengeDate: String
}

public struct UserPointResult: Decodable {
    let userPoint: Int
}

public extension UserPointResult {
    static var stub: Self {
        return .init(userPoint: 100)
    }
}
