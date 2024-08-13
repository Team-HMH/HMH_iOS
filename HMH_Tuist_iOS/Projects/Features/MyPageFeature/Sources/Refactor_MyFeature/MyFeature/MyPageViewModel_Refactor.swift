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
            
        case .revokeUser:
            container.services.authService.revokeUser()
            
        case .logout:
            container.services.authService.logoutUser()
        }
        
        //TODO: 네트워크 부분은 의존성 정리한 뒤에 다시 연결해봅시다
        func getUserData() {
            //        let provider = Providers.myPageProvider
            //        provider.request(target: .getUserData, instance: BaseResponse<GetUserDataResponseDTO>.self) { data in
            //            self.name = data.data?.name ?? ""
            //            self.point = data.data?.point ?? 0
            //        }
        }
        
        //TODO: 네트워크 부분은 의존성 정리한 뒤에 다시 연결해봅시다
        func revokeUser() {
            //        let provider = Providers.AuthProvider
            //        provider.request(target: .revoke, instance: BaseResponse<EmptyResponseDTO>.self) { data in
            //            UserManager.shared.revokeData()
            //        }
        }
        
        //TODO: 네트워크 부분은 의존성 정리한 뒤에 다시 연결해봅시다
        func logoutUser() {
            //        let provider = Providers.AuthProvider
            //        provider.request(target: .logout, instance: BaseResponse<EmptyResponseDTO>.self) { data in
            //            UserManager.shared.clearLogout()
            //        }
        }
    }
}
