//
//  SignUpDTO.swift
//  Networks
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct SignUpRequest: Encodable {
    public let socialPlatform: String
    public let name: String
    public let onboarding: OnboardingRequest
    public let challenge: ChallengeRequest
    
    public init(socialPlatform: String, name: String, onboarding: OnboardingRequest, challenge: ChallengeRequest) {
        self.socialPlatform = socialPlatform
        self.name = name
        self.onboarding = onboarding
        self.challenge = challenge
    }
}

public struct OnboardingRequest: Encodable {
    let averageUseTime: String
    let problem: [String]
    
    public init(averageUseTime: String, problem: [String]) {
        self.averageUseTime = averageUseTime
        self.problem = problem
    }
}

public struct ChallengeRequest: Encodable {
    let period: Int
    let goalTime: Int
    let apps: [AppInfoDTO]
    
    public init(period: Int, goalTime: Int, apps: [AppInfoDTO]) {
        self.period = period
        self.goalTime = goalTime
        self.apps = apps
    }
}
