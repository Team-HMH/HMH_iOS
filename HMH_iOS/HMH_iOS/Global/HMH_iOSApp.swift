//
//  HMH_iOSApp.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 2/15/24.
//

import SwiftUI

import KakaoSDKCommon
import KakaoSDKAuth

@main
struct HMH_iOSApp: App {
    @State private var isLoading: Bool = true
    @AppStorage("isOnboarding") var isOnboarding : Bool = true
    let kakaoAPIKey = Bundle.main.infoDictionary?["KAKAO_API_KEY"] as! String
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        KakaoSDK.initSDK(appKey: kakaoAPIKey)
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color(.blackground)
                
                if isLoading {
                    SplashView(isLoading: $isLoading)
                } else {
                    if isOnboarding {
                        LoginView()
                            .onOpenURL { url in
                                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                                    _ = AuthController.handleOpenUrl(url: url)
                                }
                            }
                    } else {
                        OnboardingContentView()
                    }
                }
            }
        }
    }
}

