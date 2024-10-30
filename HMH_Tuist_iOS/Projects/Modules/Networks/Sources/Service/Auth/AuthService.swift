//
//  AuthService.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

typealias AuthService = BaseService<AuthAPI>

public protocol AuthServiceType {
    func signUp(request: SignUpRequest) -> AnyPublisher<AuthResult, HMHNetworkError>
    func socialLogin(request: SocialLoginRequest) -> AnyPublisher<AuthResult, HMHNetworkError>
}

extension AuthService: AuthServiceType {
    public func signUp(request: SignUpRequest) -> AnyPublisher<AuthResult, HMHNetworkError> {
        sendRequest(.signUp(request: request))
    }
    public func socialLogin(request: SocialLoginRequest) -> AnyPublisher<AuthResult, HMHNetworkError> {
        sendRequest(.socialLogin(request: request))
    }
}

struct StubAuthService: AuthServiceType {
    func signUp(request: SignUpRequest) -> AnyPublisher<AuthResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    func socialLogin(request: SocialLoginRequest) -> AnyPublisher<AuthResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
}
