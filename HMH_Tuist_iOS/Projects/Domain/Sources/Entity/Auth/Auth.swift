//
//  Auth.swift
//  Domain
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct Auth: Equatable {
    let userId: Int
    let accessToken: String
    let refreshToken: String
    
    public init(userId: Int, accessToken: String, refreshToken: String) {
        self.userId = userId
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
