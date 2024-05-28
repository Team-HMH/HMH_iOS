//
//  UserManager.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/21/24.
//

import SwiftUI

class UserManager: ObservableObject {
    @KeychainStorage("accessToken") var accessToken
    @KeychainStorage("refreshToken") var refreshToken
    @KeychainStorage("socialToken") var socialToken
    @AppStorage("socialPlatform") var socialPlatform: String?
    @AppStorage("userName") var userName: String?
    @AppStorage("appState") var appStateString: String = AppState.login.rawValue {
        didSet {
            appState = AppState(rawValue: appStateString) ?? .login
        }
    }
    
    @Published var appState: AppState = .login
    
    static let shared = UserManager()
    
    private init() {
        appState = AppState(rawValue: appStateString) ?? .login
    }
    
    func revokeData() {
        accessToken = ""
        refreshToken = ""
        socialToken = ""
        socialPlatform = nil
        userName = nil
        appStateString = "login"
    }
    
    func logoutButtonClicked() {
        socialPlatform = nil
        appStateString = "login"
    }
    
    func updateLoginInfo(accessToken: String, refreshToken: String, socialToken: String, socialPlatform: String, userName: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.socialToken = socialToken
        self.socialPlatform = socialPlatform
        self.userName = userName
    }
    
    // 개별 업데이트 메서드 추가
    func updateRefreshToken(_ newRefreshToken: String) {
        self.refreshToken = newRefreshToken
    }
    
    func updateUserName(_ newUserName: String) {
        self.userName = newUserName
    }
}

