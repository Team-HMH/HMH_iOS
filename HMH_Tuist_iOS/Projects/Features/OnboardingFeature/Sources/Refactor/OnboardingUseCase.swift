//
//  OnboardingUseCase.swift
//  OnboardingFeatureInterface
//
//  Created by Seonwoo Kim on 11/18/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Core

public protocol OnboardingUseCaseType {
    func postSignUpData(
        socialPlatform: String,
        userName: String,
        averageUseTime: String,
        problems: [String],
        period: Int
    ) -> AnyPublisher<Void, Error>
}

public final class OnboardingUseCase: OnboardingUseCaseType {

    private let repository: AuthRepositoryType

    public init(repository: AuthRepositoryType) {
        self.repository = repository
    }
    
    public func postSignUpData(
        socialPlatform: String,
        userName: String,
        averageUseTime: String,
        problems: [String],
        period: Int
    ) -> AnyPublisher<Void, Error> {
        let challengeInfo = ChallengeInfo(period: period, goalTime: 0, apps: [])
        
        return repository.signUp(
            socialPlatform: socialPlatform,
            name: userName,
            averageUseTime: averageUseTime,
            problem: problems,
            challengeInfo: challengeInfo
        )
        .map { auth -> Void in
//            UserManager.shared.accessToken = auth.accessToken
//            UserManager.shared.refreshToken = auth.refreshToken
            print("Sign-up successful with user: \(auth)")
        }
        .mapError { error -> Error in
            print("Sign-up failed with error: \(error)")
            return error
        }
        .eraseToAnyPublisher()
    }
}

