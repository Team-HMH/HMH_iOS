//
//  UserManager.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/21/24.
//

import SwiftUI

class UserManager: ObservableObject {
    @AppStorage("accessToken") var accessToken = ""
    @AppStorage("refreshToken") var refreshToken = ""
    @AppStorage("socialToken") var socialToken = ""
    @AppStorage("socialPlatform") var socialPlatform: String?
    @AppStorage("userName") var userName: String?
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    @AppStorage("isLogin") var isLogin: Bool = false
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false

    static let shared = UserManager()
    
    private init() {}
    
    func revokeData() {
        accessToken = ""
        refreshToken = ""
        socialToken = ""
        socialPlatform = nil
        userName = nil
        isOnboarding = true
        isLogin = false
    }
    
    func logoutButtonClicked() {
        socialPlatform = nil
        isLogin = false
    }
    
    func updateLoginInfo(accessToken: String, refreshToken: String, socialToken: String, socialPlatform: String, userName: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.socialToken = socialToken
        self.socialPlatform = socialPlatform
        self.userName = userName
        self.isLogin = true
    }

    // 개별 업데이트 메서드 추가
    func updateRefreshToken(_ newRefreshToken: String) {
        self.refreshToken = newRefreshToken
    }

    func updateUserName(_ newUserName: String) {
        self.userName = newUserName
    }
}

