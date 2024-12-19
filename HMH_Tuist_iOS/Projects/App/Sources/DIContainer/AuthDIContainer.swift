//
//  AuthDIContainer.swift
//  HMH-iOS
//
//  Created by 이지희 on 11/28/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Networks
import Core
import Data
import Domain

// TODO: UseCase가 Feature안에 존재해서 import 수정 후 import 제거
import LoginFeature

final class AuthDIContainer: ObservableObject {
    
    private let services: AuthService
    private let oAuthServiceFactory: OAuthServiceFactory
    
    init(services: AuthService, oAuthServiceFactory: OAuthServiceFactory) {
        self.services = services
        self.oAuthServiceFactory = oAuthServiceFactory
    }
    
    func injectLoginViewModel() -> LoginViewModel {
        let useCase = injectLoginUseCase()
        return LoginViewModel(loginUseCase: useCase)
    }

    // MARK: Usecase
    
    private func injectLoginUseCase() -> LoginUseCase {
        let repository = injectAuthRepository()
        return LoginUseCase(repository: repository)
    }
    
    // MARK: Repository
    
    private func injectAuthRepository() -> AuthRepository {
        return AuthRepository(authService: services, oauthServiceFactory: oAuthServiceFactory)
    }
}
