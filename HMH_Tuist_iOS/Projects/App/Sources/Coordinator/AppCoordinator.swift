//
//  AppCoordinator.swift
//  Coordinator
//
//  Created by 이지희 on 11/7/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import SwiftUI

import Core
import LoginFeature
import OnboardingFeature
import MyPageFeature


final class AppCoordinator: ObservableObject, CoordinatorType {
    @Published var currentView: AnyView = AnyView(SplashView(coordinator: AppCoordinator(navigationPath: .init())))
    @Published var appState: AppState = .login
    
    var navigationPath: NavigationPath
    var parentCoordinator: (any CoordinatorType)?

    init(navigationPath: NavigationPath) {
        self.navigationPath = navigationPath
    }
    
    func start() -> AnyView {
        // 초기 상태에 따라 적절한 뷰를 설정합니다.
        showSplashScreen()
        return currentView
    }
    
    private func showSplashScreen() {
        currentView = AnyView(SplashView(coordinator: self)) // 코디네이터 주입

        /// 스플래쉬에서 토큰 검사 과정 (혹은 홈뷰 API 호출) 로 로그인 필요 여부 확인
    }
    
    func transitionToNextView() {
        switch UserManager.shared.appState {
        case .onboarding:
            currentView = AnyView(OnboardingContentView())
        case .onboardingComplete:
            currentView = AnyView(OnboardingCompleteView())
        case .servicePrepare:
            currentView = AnyView(ServicePrepareView())
        case .home:
            startTabBar()
        case .login:
            startLogin()
        }
    }
    
    func startLogin() {
        let authCoordinator = AuthCoordinator(parentCoordinator: self, navigationPath: navigationPath)
        currentView = authCoordinator.start()
    }
    
    func startTabBar() {
        let tabBarCoordinator = TabBarCoordinator(parentCoordinator: self, navigationPath: self.navigationPath)
        currentView = tabBarCoordinator.start()
    }
}
