//
//  SplashView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 4/11/24.
//

import SwiftUI

import DSKit
import Core

import Lottie

struct SplashView: View {
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        ZStack {
            LottieView(animation: .named("Splash_Bg.json"))
                .playing(loopMode: .autoReverse)
                .opacity(0.3)
                .scaleEffect(4)
            LottieView(animation: .named("Logo_wordmark_white.json"))
                .playing(loopMode: .autoReverse)
                .frame(width: 213)
                .aspectRatio(contentMode: .fit)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DSKitAsset.blackground.swiftUIColor, ignoresSafeAreaEdges: .all)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                coordinator.appState = .login // Splash에서 홈뷰 통신하면서 상태 판단 필요
            }
        }
    }
}

