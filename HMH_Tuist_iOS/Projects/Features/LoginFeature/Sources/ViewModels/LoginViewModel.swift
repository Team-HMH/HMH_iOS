//
//  LoginViewModel.swift
//  LoginFeature
//
//  Created by Seonwoo Kim on 11/8/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Core
import Domain

public final class LoginViewModel: ObservableObject {
    
    private let loginUseCase: LoginUseCaseType
    private var cancelBag = CancelBag()
    
    // 화면 이동 로직에 적용 필요
    @Published private(set) var state = State(loginStatus: .loginFailure)
    
    public init(loginUseCase: LoginUseCaseType) {
        self.loginUseCase = loginUseCase
    }
    
    // MARK: Action
    
    enum Action {
        case loginButtonDidTap(provider: OAuthProviderType)
    }
    
    // MARK: State
    
    struct State {
        var loginStatus: LoginResponseType
    }
    
    func send(action: Action) {
        switch action {
        case .loginButtonDidTap(let provider):
            loginUseCase.login(provider: provider)
                .sink(receiveCompletion: { _ in }) { [weak self] response in
                    self?.state.loginStatus = response
                }
                .store(in: cancelBag)
        }
    }
}
