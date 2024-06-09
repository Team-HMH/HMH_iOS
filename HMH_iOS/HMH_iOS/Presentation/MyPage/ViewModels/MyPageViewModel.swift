//
//  MyPageViewModel.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 4/12/24.
//

import SwiftUI

enum MyPageButtonType {
    case travel
    case market
    case term
    case info
}


class MyPageViewModel: ObservableObject {
    @Published var isPresented = false
    @Published var alertType: CustomAlertType = .logout
    @Published var name = ""
    @Published var point = 0
    @Published var navigateToPrepare = false

    func getButtonTitle(type: MyPageButtonType) -> String {
        switch type {
        case .travel:
            return StringLiteral.MyPageButton.travel
        case .market:
            return StringLiteral.MyPageButton.market
        case .term:
            return StringLiteral.MyPageButton.term
        case .info:
            return StringLiteral.MyPageButton.info
        }
    }
    
    func getButtonImage(type: MyPageButtonType) -> String? {
        switch type {
        case .travel:
            return "map"
        case .market:
            return "market"
        case .term, .info:
            return nil
        }
    }
    
    func getUserData() {
        let provider = Providers.myPageProvider
        provider.request(target: .getUserData, instance: BaseResponse<GetUserDataResponseDTO>.self) { data in
            self.name = data.data?.name ?? ""
            self.point = data.data?.point ?? 0
        }
    }
    
    func myPageButtonClick(type: MyPageButtonType) {
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
    
    func revokeUser() {
        let provider = Providers.AuthProvider
        provider.request(target: .revoke, instance: BaseResponse<EmptyResponseDTO>.self) { data in
            UserManager.shared.revokeData()
        }
    }
    
    func logoutUser() {
        let provider = Providers.AuthProvider
        provider.request(target: .logout, instance: BaseResponse<EmptyResponseDTO>.self) { data in
//            UserManager.shared.clearAll()
        }
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
