//
//  ASAuthorizationControllerProxy.swift
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
    func authorize() -> AnyPublisher<String, HMHNetworkError> {
        return self?.login().sink(receiveCompletion: { [weak self]
            
        }, receiveValue: {
            
        })
    }
    
    
    private var cancellables = Set<AnyCancellable>()
    
    func authorize() -> Future<Void, HMHNetworkError> {
        return Future { [weak self] promise in
            self?.login().sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    promise(.failure(error))
                }
            }, receiveValue: { oAuthToken in
                promise(.success(oAuthToken))
            })
            .store(in: &self!.cancellables)
        }
    }
    
    func login() -> Future<(OAuthToken, String?, String?), AuthError> {
        return Future { promise in
            let isKakaoTalkLoginAvailable = UserApi.isKakaoTalkLoginAvailable()
            
            if isKakaoTalkLoginAvailable {
                UserApi.shared.loginWithKakaoTalk()
                    .flatMap { oAuthToken in
                        UserApi.shared.me()
                            .map { user in (oAuthToken, user.kakaoAccount?.name, user.kakaoAccount?.phoneNumber) }
                            .eraseToAnyPublisher()
                    }
                    .sink(receiveCompletion: { completion in
                        if case .failure(_) = completion {
                            promise(.failure(AuthError.kakaoLoginError))
                        }
                    }, receiveValue: { data in
                        promise(.success(data))
                    })
                    .store(in: &self.cancellables)
            } else {
                UserApi.shared.loginWithKakaoAccount()
                    .flatMap { oAuthToken in
                        UserApi.shared.me()
                            .map { user in (oAuthToken, user.kakaoAccount?.name, user.kakaoAccount?.phoneNumber) }
                            .eraseToAnyPublisher()
                    }
                    .sink(receiveCompletion: { completion in
                        if case .failure(_) = completion {
                            promise(.failure(AuthError.kakaoLoginError))
                        }
                    }, receiveValue: { data in
                        promise(.success(data))
                    })
                    .store(in: &self.cancellables)
            }
        }
    }
    
    deinit {
        print("죽음")
    }
}

