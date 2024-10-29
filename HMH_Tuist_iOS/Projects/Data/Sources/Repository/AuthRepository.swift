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
    private let service: AuthServiceType
    
    init(service: AuthServiceType) {
        self.service = service
    }
    
    public func signUp(socialPlatform: String, name: String, averageUseTime: String, problem: [String], challengeInfo: ChallengeInfo) -> AnyPublisher<Auth, Error> {
        let request = SignUpRequest(
            socialPlatform: socialPlatform,
            name: name,
            onboarding: OnboardingRequest(
                averageUseTime: averageUseTime,
                problem: problem
            ),
            challenge: challengeInfo.toDTO()
        )
        return service.signUp(request: request)
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    public func socialLogin(socialPlatform: String) -> AnyPublisher<Auth, Error> {
        let request = SocialLoginRequest(socialPlatform: socialPlatform)
        return service.socialLogin(request: request)
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
}
