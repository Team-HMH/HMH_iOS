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

class MyPageViewModel: ObservableObject {
    
    private var useCase: MyPageUseCaseType
    private var cancelBag = CancelBag()
    
    init(useCase: MyPageUseCaseType) {
        self.useCase = useCase
    }
    
    @Published private(set) var state = State(
        alertType: .logout,
        name: "",
        point: 0
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
}
