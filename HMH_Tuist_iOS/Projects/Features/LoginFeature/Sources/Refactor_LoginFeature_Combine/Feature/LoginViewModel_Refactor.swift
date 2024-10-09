//
//  LoginViewModel_refactore.swift
//  LoginFeatureInterface
//
//  Created by Seonwoo Kim on 10/9/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Combine
import Core
import DSKit
import AuthenticationServices
import KakaoSDKUser

class LoginViewModel_Refactor: NSObject, ObservableObject {
    
    private var useCase: LoginUseCaseType
    private var cancelBag = CancelBag()
    
    @Published private(set) var state = State(
        loginStatus: .loginFailure
    )
    
    init(useCase: LoginUseCaseType) {
        self.useCase = useCase
    }
    
    enum Action {
        case kakaoLoginDidTap
        case appleLoginDidTap
    }
    
    struct State {
        var loginStatus: LoginResponseType
    }
    
    func send(action: Action) {
        switch action {
        case .kakaoLoginDidTap:
            handleKakaoLogin()
        case .appleLoginDidTap:
            handleAppleLogin()
        }
    }
    
    private func handleKakaoLogin() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                if let error = error {
                    print("Kakao login error: \(error)")
                    return
                }
                if let oauthToken = oauthToken {
                    let idToken = oauthToken.accessToken
                    let token = "Bearer " + idToken
                    self?.requestLoginWithSocialToken(platform: "KAKAO", token: token)
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                if let error = error {
                    print("Kakao account login error: \(error)")
                    return
                }
                if let oauthToken = oauthToken {
                    let idToken = oauthToken.accessToken
                    let token = "Bearer " + idToken
                    self?.requestLoginWithSocialToken(platform: "KAKAO", token: token)
                }
            }
        }
    }
    
    private func handleAppleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    private func requestLoginWithSocialToken(platform: String, token: String) {
        useCase.requestLogin(platform: platform, socialToken: token)
            .sink { _ in
            } receiveValue: {_ in 
                bindLoginResponse()
            }.store(in: cancelBag)
    }
    
    private func bindLoginResponse() {
        useCase.loginResponse
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] response in
                self?.state.loginStatus = response
            }).store(in: cancelBag)
    }
}

extension LoginViewModel_Refactor: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let identityToken = appleIDCredential.identityToken,
                  let idTokenString = String(data: identityToken, encoding: .utf8) else {
                print("Failed to get Apple ID token")
                return
            }
            requestLoginWithSocialToken(platform: "APPLE", token: idTokenString)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple login error: \(error.localizedDescription)")
    }
}
