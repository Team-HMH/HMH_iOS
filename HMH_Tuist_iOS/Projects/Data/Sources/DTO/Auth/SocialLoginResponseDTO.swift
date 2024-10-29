//
//  SocialLoginResponseDTO.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/14/24.
//

import Foundation

public struct SocialLogineResponseDTO: Codable {
    let userId: Int
    let token: Token
}

public struct Token: Codable {
    public let accessToken: String
    public let refreshToken: String
}
