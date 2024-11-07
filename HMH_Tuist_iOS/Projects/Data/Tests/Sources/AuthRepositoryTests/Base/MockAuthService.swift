//
//  MockAuthService.swift
//  Data
//
//  Created by 류희재 on 11/6/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

final public class MockAuthService: AuthServiceType {
    
    public init() {}
    
    public var signUpResult:AnyPublisher<AuthResult, HMHNetworkError>!
    public var socialLoginResult:AnyPublisher<AuthResult, HMHNetworkError>!
    
    public func signUp(request: SignUpRequest) -> AnyPublisher<AuthResult, HMHNetworkError> {
        return signUpResult
    }
    
    public func socialLogin(request: SocialLoginRequest) -> AnyPublisher<AuthResult, HMHNetworkError> {
        return socialLoginResult
    }
}
