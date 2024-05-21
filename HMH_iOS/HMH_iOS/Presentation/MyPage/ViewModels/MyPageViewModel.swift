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
    
    func getUserName() -> String {
        "김하면함"
    }
    
    func getUserPoint() -> String {
        "100p"
    }
    
    func myPageButtonClick(type: MyPageButtonType) {
        switch type {
        case .term:
            guard let url = URL(string: StringLiteral.MyPageURL.term) else {return}
            UIApplication.shared.open(url)
        case .info:
            guard let url = URL(string: StringLiteral.MyPageURL.info) else {return}
            UIApplication.shared.open(url)
        default:
            return
        }
    }
    
    func logoutButtonClicked() {
        alertType = .logout
        isPresented = true
    }
    
    func withdrawButtonClicked() {
        alertType = .withdraw
        isPresented = true
    }
    
    func revokeUser() {
        let provider = Providers.AuthProvider
        provider.request(target: .revoke, instance: BaseResponse<EmptyResponseDTO>.self) { data in
            UserManager.shared.logout()
        }
    }
}
