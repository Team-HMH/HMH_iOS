//
//  HMH_iOSApp.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI

import KakaoSDKCommon
import KakaoSDKAuth

@main
struct HMH_iOSApp: App {
    let kakaoAPIKey = Bundle.main.infoDictionary?["KAKAO_API_KEY"] as! String
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase

    init() {
        KakaoSDK.initSDK(appKey: kakaoAPIKey)
    }

    var body: some Scene {
        WindowGroup {
            AppView()
        }
    }
}
