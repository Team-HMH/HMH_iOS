//
//  LoginUseCase.swift
//  LoginFeature
//
//  Created by Seonwoo Kim on 11/8/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Core

public enum LoginResponseType {
    case loginSuccess
    case loginFailure
    case onboardingNeeded
}

public protocol LoginUseCaseType {
    func login(provider: OAuthProviderType) -> AnyPublisher<LoginResponseType, AuthError>
}

public final class LoginUseCase: LoginUseCaseType {
    
    private let repository: AuthRepositoryType
    
    public init(repository: AuthRepositoryType) {
        self.repository = repository
    }
    
    public func login(provider: OAuthProviderType) -> AnyPublisher<LoginResponseType, Domain.AuthError> {
        repository.authorize(provider)
            .handleEvents(receiveOutput: { socialToken in
                UserManager.shared.socialToken = socialToken
            })
            .flatMap { [weak self] _ -> AnyPublisher<LoginResponseType, AuthError> in
                guard let self = self else {
                    return Fail(error: AuthError.appleAuthrizeError).eraseToAnyPublisher()
                }
                
                return self.repository.socialLogin(socialPlatform: provider.rawValue)
                    .map { _ in LoginResponseType.loginSuccess }
                    .catch { error -> AnyPublisher<LoginResponseType, AuthError> in
                        switch error {
                        case .unregisteredUser:
                            return Just(.onboardingNeeded)
                                .setFailureType(to: AuthError.self)
                                .eraseToAnyPublisher()
                        default:
                            return Just(.loginFailure)
                                .setFailureType(to: AuthError.self)
                                .eraseToAnyPublisher()
                        }
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

