//
//  UserManager.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/21/24.
//

import SwiftUI

public class UserManager: ObservableObject {
    @KeychainStorage("accessToken") public var accessToken
    @KeychainStorage("refreshToken") public var refreshToken
    @KeychainStorage("socialToken") public var socialToken
    @AppStorage("socialPlatform") public var socialPlatform: String?
    @AppStorage("userName") public var userName: String?
    @AppStorage("appState") public var appStateString: String = AppState.login.rawValue {
        didSet {
            appState = AppState(rawValue: appStateString) ?? .login
        }
    }
    
    @Published var appState: AppState = .login
    @Published var isFirstLogin: Bool {
        didSet {
            UserDefaults.standard.set(isFirstLogin, forKey: "isFirstLogin")
        }
    }
   
    //TODO: 의존성 주입 or 다른 방법으로 바꿔야 합니다!!! 최악의 방법인 싱글톤
    public static let shared = UserManager()
    
    private init() {
        self.isFirstLogin = UserDefaults.standard.bool(forKey: "isFirstLogin")
        appState = AppState(rawValue: appStateString) ?? .login
    }
    
    func clearLogout() {
        accessToken = ""
        refreshToken = ""
        socialToken = ""
        appStateString = "login"
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

