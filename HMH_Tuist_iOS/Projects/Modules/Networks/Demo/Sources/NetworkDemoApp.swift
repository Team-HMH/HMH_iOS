//
//  NetworkDemoApp.swift
//  Data
//
//  Created by 류희재 on 11/21/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import SwiftUI

import Domain
import Networks

import KakaoSDKCommon
import KakaoSDKAuth

@main
struct NetworkTestApp: App {
    let kakaoAPIKey = Config.appKey
    init() {
        KakaoSDK.initSDK(appKey: kakaoAPIKey)
    }
    
    @StateObject var container = DIContainer.default
    
    var body: some Scene {
        WindowGroup {
            TokenTestHomeView()
                .environmentObject(container)
        }
    }
}
