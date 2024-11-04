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

public extension SignUpRequest {
    static var stub: Self {
        .init(
            socialPlatform: "KAKAO", 
            name: "류희재",
            onboarding: .stub,
            challenge: .stub
        )
    }
}

public extension OnboardingRequest {
    static var stub: Self {
        .init(averageUseTime: "1~4시간", problem: ["스스로 제어가 안돼요", "특정 앱에 수시로 접속하게 됨"])
    }
}

public extension ChallengeRequest {
    static var stub: Self {
        .init(period: 7, goalTime: 7200000, apps: [.stub])
    }
}
