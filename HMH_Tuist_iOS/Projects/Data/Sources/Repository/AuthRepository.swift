//
//  AuthRepository.swift
//  Data
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

public struct AuthRepository: AuthRepositoryType {
    
    private let authService: AuthServiceType
    private let oauthServiceFactory: OAuthServiceFactoryType
    
    init(authService: AuthServiceType, oauthServiceFactory: OAuthServiceFactoryType) {
        self.authService = authService
        self.oauthServiceFactory = oauthServiceFactory
    }
    
    public func authorize(_ serviceType: OAuthProviderType) -> AnyPublisher<String, Error> {
        let oauthService = oauthServiceFactory.makeOAuthService(for: serviceType)
        return oauthService.authorize()
            .map { $0 }
            .mapToGeneralError()
    }
    
    public func signUp(socialPlatform: String, name: String, averageUseTime: String, problem: [String], challengeInfo: ChallengeInfo) -> AnyPublisher<Auth, AuthError> {
        let request = SignUpRequest(
            socialPlatform: socialPlatform,
            name: name,
            onboarding: OnboardingRequest(
                averageUseTime: averageUseTime,
                problem: problem
            ),
            challenge: challengeInfo.toDTO()
        )
        
        return authService.signUp(request: request)
            .map { $0.toEntity() }
            .mapToDomainError(to: AuthError.self)
    }
    
    public func socialLogin(socialPlatform: String) -> AnyPublisher<Auth, AuthError> {
        let request = SocialLoginRequest(socialPlatform: socialPlatform)
        
        return authService.socialLogin(request: request)
            .map { $0.toEntity() }
            .mapToDomainError(to: AuthError.self)
    }
}
