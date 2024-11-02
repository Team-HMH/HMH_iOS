//
//  OAuthProviderType.swift
//  Data
//
//  Created by 류희재 on 11/2/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

/**
 - description: OAuth 서비스를 제공하는 제공자 종류
    우리 서비스의 경우 Apple, Kakao 서비스 사용
 */

public enum OAuthProvider: OAuthProviderType {
    case kakao
    case apple
    
    public var socialPlatform: String {
        switch self {
        case .kakao:
            return "KAKAO"
        case .apple:
            return "APPLE"
        }
    }
    
    public var service: OAuthServiceType {
        switch self {
        case .kakao:
            return OAuthKakaoService()
        case .apple:
            return OAuthAppleService()
        }
    }
}



