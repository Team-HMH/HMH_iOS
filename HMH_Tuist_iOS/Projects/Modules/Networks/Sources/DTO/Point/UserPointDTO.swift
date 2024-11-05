//
//  UserPoint.swift
//  Networks
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct UserPointRequest: Encodable {
    let challengeDate: String
    
    public init(challengeDate: String) {
        self.challengeDate = challengeDate
    }
}

public struct UserPointResult: Decodable {
    public let userPoint: Int
    
    public init(userPoint: Int) {
        self.userPoint = userPoint
    }
}

public extension UserPointResult {
    static var stub: Self {
        return .init(userPoint: 100)
    }
}
