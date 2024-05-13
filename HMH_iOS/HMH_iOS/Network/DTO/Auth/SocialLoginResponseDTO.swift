//
//  SocialLoginResponseDTO.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/14/24.
//

import Foundation

struct SocialLogineResponseDTO: Codable {
    let userId: Int
    let token: Token
}

struct Token: Codable {
    let accessToken: String
    let refreshToken: String
}
