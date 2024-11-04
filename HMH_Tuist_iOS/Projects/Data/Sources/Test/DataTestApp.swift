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
    let kakaoAPIKey = Bundle.main.infoDictionary?["KAKAO_API_KEY"] as! String
    init() {
        KakaoSDK.initSDK(appKey: kakaoAPIKey)
    }
    
    var body: some Scene {
        WindowGroup {
            NetworkTestUI(
                repository: AuthRepository(
                    authService: AuthService(requestHandler: RequestHandler()),
                    oauthServiceFactory: OAuthServiceFactory()
                )
            )
        }
    }
}
