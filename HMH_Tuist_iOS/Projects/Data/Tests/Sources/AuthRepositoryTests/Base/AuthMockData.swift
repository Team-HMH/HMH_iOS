//
//  SocialLoginMockData.swift
//  Data
//
//  Created by 류희재 on 11/6/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension Auth {
    static public var expectedData: [Auth] {
        return [
            .init(userId: 1, accessToken: "123123", refreshToken: "456456"),
            .init(userId: 2, accessToken: "", refreshToken: "456456"),
            .init(userId: 3, accessToken: "123123", refreshToken: ""),
           
        ]
    }
}

extension AuthResult {
    static public var resultData: [AuthResult] {
        return [
            .init(userId: 1, token: TokenResult(accessToken: "123123", refreshToken: "456456")),
            .init(userId: 2, token: TokenResult(accessToken: "", refreshToken: "456456")),
            .init(userId: 3, token: TokenResult(accessToken: "123123", refreshToken: "")),
        ]
    }
}



