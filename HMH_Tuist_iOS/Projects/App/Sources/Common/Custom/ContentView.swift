//
//  ContentView.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 2/15/24.
//

import SwiftUI

import KakaoSDKAuth

import LoginFeature
import OnboardingFeature
import MyPageFeature
import HomeFeature

import DSKit
import Core

struct ContentView: View {
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var userManager = UserManager.shared
    @StateObject var appStateViewModel = AppStateViewModel.shared
    
    @State private var showWelcomeAlert = false
    
    var body: some View {
        ZStack {
            Color(DSKitAsset.blackground.swiftUIColor)
                .ignoresSafeArea()
            if loginViewModel.isLoading {
                SplashView(viewModel: loginViewModel)
            } else {
                switch userManager.appState {
                case .onboarding:
                    OnboardingContentView()
                case .onboardingComplete:
                    OnboardingCompleteView()
                case .servicePrepare:
                    ServicePrepareView()
                case .home:
                    TabBarView()
                        .onAppear {
                            appStateViewModel.onAppear()
                            if userManager.isFirstLogin {
                                showWelcomeAlert = true
                                userManager.isFirstLogin = false
                            }
                        }
                        .overlay(
                            CustomAlertView(
                                alertType: appStateViewModel.currentAlertType,
                                confirmBtn: CustomAlertButtonView(
                                    buttonType: .Confirm,
                                    alertType: appStateViewModel.currentAlertType,
                                    isPresented: $appStateViewModel.showCustomAlert,
                                    action: {
                                        appStateViewModel.cancelAlert()
                                    }
                                ),
                                cancelBtn: CustomAlertButtonView(
                                    buttonType: .Cancel,
                                    alertType: appStateViewModel.currentAlertType,
                                    isPresented: $appStateViewModel.showCustomAlert,
                                    action: {
                                        appStateViewModel.nextAlert()
                                    }
                                ), currentPoint: appStateViewModel.currentPoint, usagePoint: appStateViewModel.usagePoint
                            )
                            .opacity(appStateViewModel.showCustomAlert ? 1 : 0)
                        )
                        .overlay(
                            GuideView(isPresented: $showWelcomeAlert)
                                .opacity(showWelcomeAlert ? 1 : 0)
                        )
                case .login:
                    LoginView(viewModel: loginViewModel)
                        .onOpenURL { url in
                            if AuthApi.isKakaoTalkLoginUrl(url) {
                                _ = AuthController.handleOpenUrl(url: url)
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
