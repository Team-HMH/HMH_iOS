//
//  OAuthSerivce.swift
//  Networks
//
//  Created by 류희재 on 10/31/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

protocol OAuthServiceType {
    func authorize() -> AnyPublisher<String, HMHNetworkError.AuthError>
}

final class OAuthSerivce: OAuthServiceType {
    func authorize() -> AnyPublisher<String, HMHNetworkError.AuthError> {
        return Just("")
            .setFailureType(to: HMHNetworkError.AuthError.self)
            .eraseToAnyPublisher()
    }
}

final class StubOAuthService: OAuthServiceType {
    func authorize() -> AnyPublisher<String, HMHNetworkError.AuthError> {
        return Just("")
            .setFailureType(to: HMHNetworkError.AuthError.self)
            .eraseToAnyPublisher()
    }
    
    
}
