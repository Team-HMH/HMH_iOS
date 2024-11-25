//
//  DataTestApp.swift
//  Data
//
//  Created by 류희재 on 11/2/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import SwiftUI

import Domain
import Networks

import KakaoSDKCommon
import KakaoSDKAuth

@main
struct DataTestApp: App {
    let kakaoAPIKey = Networks.Config.appKey
    init() {
        KakaoSDK.initSDK(appKey: kakaoAPIKey)
        print(Networks.Config.baseURL)
    }
    
    var body: some Scene {
        WindowGroup {
            NetworkTestUI(
                repository: AuthRepository(
                    authService: AuthService(),
                    oauthServiceFactory: OAuthServiceFactory()
                )
            )
        }
    }
}
