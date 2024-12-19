//
//  AppView.swift
//  HMH-iOS
//
//  Created by 이지희 on 11/15/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import SwiftUI

import KakaoSDKAuth

import DSKit
import Core

struct AppView: View {
    @EnvironmentObject var appDIContainer: AppDIContainer
    @StateObject var coordinator = AppCoordinator(navigationPath: .init())
    
    var body: some View {
        ZStack {
            Color(DSKitAsset.blackground.swiftUIColor)
                .ignoresSafeArea(.all)
            coordinator.start()
        }
        .onOpenURL { url in
            if AuthApi.isKakaoTalkLoginUrl(url) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
}
