//
//  LoginViewModel.swift
//  LoginFeature
//
//  Created by Seonwoo Kim on 11/8/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Core
import Domain

final class LoginViewModel: ObservableObject {
    @Published var loginStatus: LoginResponseType = .loginFailure
    
    private var cancelBag = CancelBag()
    
    private let loginUseCase: LoginUseCaseType
    
    init(loginUseCase: LoginUseCaseType) {
        self.loginUseCase = loginUseCase
    }
    
    func handleLoginButton(provider: OAuthProviderType) {
        loginUseCase.login(provider: provider)
            .sink(receiveCompletion: { _ in }) { [weak self] response in
                self?.loginStatus = response
            }
            .store(in: cancelBag)
    }
}
