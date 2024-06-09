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
    let kakaoAPIKey = Bundle.main.infoDictionary?["KAKAO_API_KEY"] as! String
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var scheduler = MidnightTaskScheduler()
    @Environment(\.scenePhase) private var scenePhase

    init() {
        KakaoSDK.initSDK(appKey: kakaoAPIKey)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .background:
                print("App moved to background.")
                scheduler.scheduleMidnightTask()
            @unknown default:
                break
            }
        }
    }
}
