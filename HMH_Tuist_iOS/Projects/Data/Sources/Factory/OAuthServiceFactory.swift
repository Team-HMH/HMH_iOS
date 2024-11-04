//
//  OAuthServiceFactory.swift
//  Data
//
//  Created by 류희재 on 11/2/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

public protocol OAuthServiceFactoryType {
    func makeOAuthService(for providerType: OAuthProviderType) -> OAuthServiceType
}

public class OAuthServiceFactory: OAuthServiceFactoryType {
    public init() {}

    public func makeOAuthService(for providerType: OAuthProviderType) -> OAuthServiceType {
        switch providerType {
        case .kakao:
            return OAuthKakaoService()
        case .apple:
            return OAuthAppleService()
        }
    }
}
