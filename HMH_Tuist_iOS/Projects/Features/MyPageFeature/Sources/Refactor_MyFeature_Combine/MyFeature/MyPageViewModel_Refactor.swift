//
//  MyPageViewModel.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 4/12/24.
//

import SwiftUI
import Combine

import Core
import DSKit

class MyPageViewModel_Refactor: ObservableObject {
    
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
    
    struct State {
        var alertType: CustomAlertType
        var name: String
        var point: Int
    }
    
    func send(action: Action) {
        switch action {
        case .onAppearEvent:
            useCase.getUserDate()
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
