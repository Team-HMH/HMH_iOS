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
import DSKit

public final class LoginViewModel: ObservableObject {
    
    private let loginUseCase: LoginUseCaseType
    private var cancelBag = CancelBag()
    
    // 화면 이동 로직과 스와이프 인덱스 포함
    @Published private(set) var state = State(loginStatus: .loginFailure, swipeImageIndex: 0)
    
    public init(loginUseCase: LoginUseCaseType) {
        self.loginUseCase = loginUseCase
        startImageTimer()
    }
    
    // MARK: Action
    
    enum Action {
        case loginButtonDidTap(provider: OAuthProviderType)
        case swipeButtonDidTap(index: Int)
    }
    
    // MARK: State
    
    struct State {
        var loginStatus: LoginResponseType
        var swipeImageIndex: Int
    }
    
    func send(action: Action) {
        switch action {
        case .loginButtonDidTap(let provider):
            loginUseCase.login(provider: provider)
                .sink(receiveCompletion: { _ in }) { [weak self] response in
                    self?.state.loginStatus = response
                }
                .store(in: cancelBag)
        case .swipeButtonDidTap(let index):
            self.state.swipeImageIndex = index
        }
    }
    
    private func startImageTimer() {
        Timer.publish(every: 3.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.state.swipeImageIndex = ((self?.state.swipeImageIndex ?? 0) + 1) % 3
            }
            .store(in: cancelBag)
    }
    
}
