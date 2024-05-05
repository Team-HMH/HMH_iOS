//
//  HMH_iOSApp.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 2/15/24.
//

import SwiftUI

@main
struct HMH_iOSApp: App {
    @State private var isLoading: Bool = true
    @AppStorage("isOnboarding") var isOnboarding : Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isLoading {
                    SplashView(isLoading: $isLoading)
                } else {
                    if isOnboarding {
                        TabBarView()
                    } else {
                        OnboardingContentView()
                    }
                }
            }
        }
    }
}

