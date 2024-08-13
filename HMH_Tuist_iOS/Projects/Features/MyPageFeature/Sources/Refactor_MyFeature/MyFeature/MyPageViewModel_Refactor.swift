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
    
    private var container: DIContainer
    private var cancelBag = CancelBag()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    @Published var alertType: CustomAlertType = .logout
    @Published var name = ""
    @Published var point = 0
    @Published var navigateToPrepare = false
    
    //MARK: Action
    enum Action {
        case getUserData
        case revokeUser
        case logout
    }
    
    func send(action: Action) {
        switch action {
        case .getUserData:
            container.services.userService.getUserData()
                .sink { _ in
                    
                } receiveValue: { [weak self] data in
                    self?.name = data.data?.name ?? ""
                    self?.point = data.data?.point ?? 0
                }.store(in: cancelBag)
            
        case .revokeUser:
            container.services.authService.revokeUser()
                .sink { _ in
                } receiveValue: {  _ in
                    UserManager.shared.revokeData()
                }.store(in: cancelBag)
            
        case .logout:
            container.services.authService.logoutUser()
                .sink { _ in
                } receiveValue: {  _ in
                    UserManager.shared.revokeData()
                }.store(in: cancelBag)
        }
    }
}
