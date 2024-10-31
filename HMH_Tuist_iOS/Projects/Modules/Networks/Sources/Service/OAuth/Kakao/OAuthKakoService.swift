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

final class OAuthKakaoService: OAuthServiceType {
    
    private var cancellables = Set<AnyCancellable>()
    
    func authorize() -> AnyPublisher<String, HMHNetworkError.AuthError> {
        return login()
            .map { $0.accessToken }
            .eraseToAnyPublisher()
    }
    
    func login() -> Future<OAuthToken, HMHNetworkError.AuthError> {
        return Future { [weak self] promise in
            let isKakaoTalkLoginAvailable = UserApi.isKakaoTalkLoginAvailable()
            let userApi = UserApi.shared
            
            let loginPublisher: AnyPublisher<OAuthToken, HMHNetworkError.AuthError>
            
            if isKakaoTalkLoginAvailable {
                loginPublisher = Future<OAuthToken, HMHNetworkError.AuthError> { promise in
                    userApi.loginWithKakaoTalk { (token, error) in
                        if let token = token {
                            promise(.success(token))
                        } else {
                            promise(.failure(.kakaoLoginError))
                        }
                    }
                }
                .flatMap { token -> AnyPublisher<OAuthToken, HMHNetworkError.AuthError> in
                    return Future<OAuthToken, HMHNetworkError.AuthError> { promise in
                        userApi.me { user, error in
                            if let _ = user {
                                promise(.success(token))
                            } else {
                                promise(.failure(.kakaoLoginError))
                            }
                        }
                    }
                    .eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
            } else {
                loginPublisher = Future<OAuthToken, HMHNetworkError.AuthError> { promise in
                    userApi.loginWithKakaoAccount { (token, error) in
                        if let token = token {
                            promise(.success(token))
                        } else {
                            promise(.failure(.kakaoLoginError))
                        }
                    }
                }
                .flatMap { token -> AnyPublisher<OAuthToken, HMHNetworkError.AuthError> in
                    return Future<OAuthToken, HMHNetworkError.AuthError> { promise in
                        userApi.me { user, error in
                            if let _ = user {
                                promise(.success(token))
                            } else {
                                promise(.failure(.kakaoLoginError))
                            }
                        }
                    }
                    .eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
            }
            
            loginPublisher
                .sink(receiveCompletion: { completion in
                    if case .failure = completion {
                        promise(.failure(.kakaoLoginError))
                    }
                }, receiveValue: { token in
                    promise(.success(token))
                })
                .store(in: &self!.cancellables)
        }
    }
    
    deinit {
        print("OAuthKakaoService deinitialized")
    }
}
