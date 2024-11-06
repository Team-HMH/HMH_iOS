//
//  SocialLoginDTO.swift
//  Networks
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct AuthResult: Decodable {
    
    public init(userId: Int, token: TokenResult) {
        self.userId = userId
        self.token = token
    }
    
    public let userId: Int
    public let token: TokenResult
}

public extension AuthResult {
    static var stub: Self {
        return .init(
            userId: 1,
            token: TokenResult(
                accessToken: "",
                refreshToken: ""
            )
        )
    }
}
