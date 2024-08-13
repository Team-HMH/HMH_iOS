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
        case logoutButtonClicked
        case myPageButtonClick(MyPageButtonType)
    }
    
    func send(action: Action) {
        switch action {
        case .getUserData:
            container.services.userService.getUserData()
        case .revokeUser:
            container.services.authService.revokeUser()
        case .logoutButtonClicked:
            container.services.authService.logoutUser()
        case let .myPageButtonClick(type):
            switch type {
            case .term:
                guard let url = URL(string: StringLiteral.MyPageURL.term) else {return}
                UIApplication.shared.open(url)
            case .info:
                guard let url = URL(string: StringLiteral.MyPageURL.info) else {return}
                UIApplication.shared.open(url)
            case .market:
                navigateToPrepare = true
            default:
                return
            }
            }
        }
    }
    
    
    
    //TODO: 네트워크 부분은 의존성 정리한 뒤에 다시 연결해봅시다
    func getUserData() {
//        let provider = Providers.myPageProvider
//        provider.request(target: .getUserData, instance: BaseResponse<GetUserDataResponseDTO>.self) { data in
//            self.name = data.data?.name ?? ""
//            self.point = data.data?.point ?? 0
//        }
    }
    
//    func myPageButtonClick(type: MyPageButtonType) {
//        switch type {
//        case .term:
//            guard let url = URL(string: StringLiteral.MyPageURL.term) else {return}
//            UIApplication.shared.open(url)
//        case .info:
//            guard let url = URL(string: StringLiteral.MyPageURL.info) else {return}
//            UIApplication.shared.open(url)
//        case .market:
//            navigateToPrepare = true
//        default:
//            return
//        }
//    }
    
    func backButtonClicked() {
        navigateToPrepare = false
    }
    
    func logoutButtonClicked() {
        isPresented = true
        alertType = .logout
    }
    
    func withdrawButtonClicked() {
        isPresented = true
        alertType = .withdraw
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
    
    func confirmAction() {
        UserManager.shared.appStateString = "login"
        if alertType == .logout {
            logoutUser()
            isPresented = false
        } else {
            revokeUser()
            UserManager.shared.revokeData()
            isPresented = false
        }
    }
    
    func cancelAction() {
        isPresented = false
    }
}
