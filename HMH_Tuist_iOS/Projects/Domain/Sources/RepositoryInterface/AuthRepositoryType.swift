//
//  AuthRepositoryType.swift
//  Domain
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol AuthRepositoryType {
    func authorize(_ serviceType: OAuthProviderType) -> AnyPublisher<String, AuthError>
    func signUp(
        socialPlatform: String,
        name: String,
        averageUseTime: String,
        problem: [String],
        challengeInfo: ChallengeInfo
    ) -> AnyPublisher<Auth, AuthError>
    func socialLogin(socialPlatform: String) -> AnyPublisher<Auth, AuthError>
    
}
