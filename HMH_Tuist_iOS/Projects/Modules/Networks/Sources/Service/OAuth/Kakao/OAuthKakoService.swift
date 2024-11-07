//
//  OAuthKakoService.swift
//  Networks
//
//  Created by 류희재 on 10/31/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser
import Core

public final class OAuthKakaoService: OAuthServiceType {
    
    public init() {} 
    let cancelBag = CancelBag()
    
    public func authorize() -> AnyPublisher<String, HMHNetworkError> {
        return login()
            .map { $0.accessToken }
            .eraseToAnyPublisher()
    }
    
    private func login() -> Future<OAuthToken, HMHNetworkError> {
        return Future { promise in
            let userApi = UserApi.shared
            
            if UserApi.isKakaoTalkLoginAvailable() {
                userApi.loginWithKakaoTalk { (token, error) in
                    guard let token else {
                        return promise(.failure(.oautheticationError(.kakaoLoginError)))
                    }
                    promise(.success(token))
                }
            } else {
                userApi.loginWithKakaoAccount { (token, error) in
                    guard let token else {
                        return promise(.failure(.oautheticationError(.kakaoLoginError)))
                    }
                    promise(.success(token))
                }
            }
        }
    }
    
    deinit {
        print("OAuthKakaoService deinitialized")
    }
}
