//
//  MyPageViewModel.swift
//  MyPageFeature
//
//  Created by 류희재 on 11/26/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Combine

import Core
import DSKit
import Domain
import Foundation

public class MyPageViewModel: ObservableObject {
    
    private var useCase: MyPageUseCaseType
    private var cancelBag = CancelBag()
    
    public init(useCase: MyPageUseCaseType) {
        self.useCase = useCase
        
        bindState()
    }
    
    @Published private(set) var state = State(
        alertType: .logout,
        user: User(name: "유저정보를 불러오는 중입니다...", point: 0),
        showToast: ""
    )
    
    //MARK: Action
    
    enum Action {
        case onAppearEvent
        case logoutButtonDidTap
        case withdrawButtonDidTap
        case confirmButtonDidTap
    }
    
    //MARK: State
    
    struct State {
        var alertType: CustomAlertType
        var user: User
        var showToast: String
    }
    
    func send(action: Action) {
        switch action {
        case .onAppearEvent:
            useCase.getUserData()
                .catch { _ in Empty() }
                .receive(on: RunLoop.main)
                .assign(to: \.state.user, on: self)
                .store(in: cancelBag)
            
        case .logoutButtonDidTap:
            state.alertType = .logout
            
        case .withdrawButtonDidTap:
            state.alertType = .withdraw
            
        case .confirmButtonDidTap:
            state.alertType == .logout
            ? handleLogout()
            : handleRevokeUser()
        }
    }
    
    private func bindState() {
        useCase.logoutFailed
            .merge(with: useCase.revokeUserFailed)
            .receive(on: RunLoop.main)
            .assign(to: \.state.showToast, on: self)
            .store(in: cancelBag)
    }
}

extension MyPageViewModel {
    func handleLogout() {
        useCase.logout()
            .sink(receiveValue: {
                //여기서 화면전환
                UserManager.shared.appStateString = "login"
            }).store(in: cancelBag)
    }
    
    func handleRevokeUser() {
        useCase.revokeUser()
            .sink(receiveValue: {
                //여기서 화면전환
                UserManager.shared.appStateString = "login"
            }).store(in: cancelBag)
    }
}

