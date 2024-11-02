//
//  OAuthAppleService.swift
//  Networks
//
//  Created by 류희재 on 10/31/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import AuthenticationServices
import Combine

public final class OAuthAppleService: OAuthServiceType {
    public init() {} 
    
    private let appleLoginManager = AppleLoginManager()
    
    public func authorize() -> AnyPublisher<String, HMHNetworkError.AuthError> {
        return login()
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    private func login() -> AnyPublisher<String, HMHNetworkError.AuthError> {
        return self.appleLoginManager.handleAuthorizationAppleIDButtonPress()
            .tryMap { result -> String in
                guard
                    let credential = result.credential as? ASAuthorizationAppleIDCredential,
                    let idToken = credential.identityToken,
                    let idTokenString = String(data: idToken, encoding: .utf8)
                else {
                    throw HMHNetworkError.AuthError.appleLoginError
                }
                return idTokenString
            }
            .mapError { _ in HMHNetworkError.AuthError.appleLoginError }
            .eraseToAnyPublisher()
    }
}
