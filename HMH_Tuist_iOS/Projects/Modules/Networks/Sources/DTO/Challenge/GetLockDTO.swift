//
//  GetLockDTO.swift
//  Data
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct GetLockResult: Decodable {
    public let isLockToday: Bool
    
    public init(isLockToday: Bool) {
        self.isLockToday = isLockToday
    }
}

public extension GetLockResult {
    static var stub: Self {
        .init(isLockToday: true)
    }
}
