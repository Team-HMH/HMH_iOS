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
        case updateSwipeIndex
        case setSwipeIndex(index: Int)
    }
    
    // MARK: State
    
    struct State {
        var loginStatus: LoginResponseType
        var swipeImageIndex: Int
    }
    
    private func startImageTimer() {
        Timer.publish(every: 3.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.send(action: .updateSwipeIndex)
            }
            .store(in: cancelBag)
    }
    
    func send(action: Action) {
        switch action {
        case .loginButtonDidTap(let provider):
            loginUseCase.login(provider: provider)
                .sink(receiveCompletion: { _ in }) { [weak self] response in
                    self?.state.loginStatus = response
                }
                .store(in: cancelBag)
        case .updateSwipeIndex:
            self.state.swipeImageIndex = (state.swipeImageIndex + 1) % 3
        case .setSwipeIndex(let index):
            self.state.swipeImageIndex = index
        }
    }
}
