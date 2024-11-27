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
        period: Int,
        goalTime: Int
    ) -> AnyPublisher<Void, Error>
    func calculateGoalTime(hour: String, minute: String) -> Int
    func removeLastCharacterAndConvertToInt(from string: String) -> Int?
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
        period: Int,
        goalTime: Int
    ) -> AnyPublisher<Void, Error> {
        let challengeInfo = ChallengeInfo(period: period, goalTime: goalTime, apps: [])
        
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
        }
        .mapError { error -> Error in
  
            return error
        }
        .eraseToAnyPublisher()
    }
    
    public func calculateGoalTime(hour: String, minute: String) -> Int {
        let hourInt = Int(hour) ?? 0
        let minuteInt = Int(minute) ?? 0
        
        let totalMinutes = hourInt * 60 + minuteInt
        let totalMilliseconds = totalMinutes * 60 * 1000
        return totalMilliseconds
    }
    
    public func removeLastCharacterAndConvertToInt(from string: String) -> Int? {
        guard !string.isEmpty else {
            return nil
        }
        
        let modifiedString = String(string.dropLast())
        
        return Int(modifiedString)
    }
}

