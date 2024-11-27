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

class MyPageViewModel: ObservableObject {
    
    private var useCase: MyPageUseCaseType
    private var cancelBag = CancelBag()
    
    init(useCase: MyPageUseCaseType) {
        self.useCase = useCase
        
        bindState()
    }
    
    @Published private(set) var state = State(
        alertType: .logout,
        name: "",
        point: 0,
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
        var name: String
        var point: Int
        var showToast: String
    }
    
    func send(action: Action) {
        switch action {
        case .onAppearEvent:
            useCase.getUserData()
                .sink { _ in
                } receiveValue: { [weak self] data in
                    self?.state.name = data.name
                    self?.state.point = data.point
                }.store(in: cancelBag)
            
        case .logoutButtonDidTap:
            state.alertType = .logout
            
        case .withdrawButtonDidTap:
            state.alertType = .withdraw
            
        case .confirmButtonDidTap:
            state.alertType == .logout ? useCase.logout() : useCase.revokeUser()
        }
    }
    
    func bindState() {
        useCase.loginFailed
            .merge(with: useCase.revokeUserFailed)
            .receive(on: RunLoop.main)
            .assign(to: \.state.showToast, on: self)
            .store(in: cancelBag)
    }
}

