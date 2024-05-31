//
//  HMH_iOSApp.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI

import KakaoSDKCommon
import KakaoSDKAuth

enum AppState: String {
    case login
    case onboarding
    case onboardingComplete
    case home
}


@main
struct HMH_iOSApp: App {
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var userManager = UserManager.shared
    @StateObject private var scheduler = MidnightTaskScheduler()
    
    let kakaoAPIKey = Bundle.main.infoDictionary?["KAKAO_API_KEY"] as! String
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        KakaoSDK.initSDK(appKey: kakaoAPIKey)
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color(.blackground)
                    .ignoresSafeArea()
                if loginViewModel.isLoading {
                    SplashView(viewModel: loginViewModel)
                } else {
                    switch userManager.appState {
                    case .onboarding:
                        OnboardingContentView()
                    case .onboardingComplete:
                        OnboardingCompleteView()
                    case .home:
                        TabBarView()
                    case .login:
                        LoginView(viewModel: loginViewModel)
                            .onOpenURL { url in
                                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                                    _ = AuthController.handleOpenUrl(url: url)
                                }
                            }
                    }
                }
            }
            .onAppear {
                scheduler.testTask()
            }
        }
    }
}
