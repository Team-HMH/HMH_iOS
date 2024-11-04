//
//  AuthMapper.swift
//  Data
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension AuthResult {
    func toEntity() -> Auth {
        .init(
            userId: userId,
            accessToken: token.accessToken,
            refreshToken: token.refreshToken
        )
    }
}


