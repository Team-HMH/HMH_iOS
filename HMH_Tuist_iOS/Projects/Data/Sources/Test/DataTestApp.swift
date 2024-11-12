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
    let kakaoAPIKey = "36f13382883fc31f22b7d34148a1be2b"
    init() {
        KakaoSDK.initSDK(appKey: kakaoAPIKey)
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
