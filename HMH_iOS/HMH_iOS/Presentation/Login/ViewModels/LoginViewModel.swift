//
//  LoginViewModel.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/5/24.
//

import SwiftUI
import AuthenticationServices

import KakaoSDKUser

class LoginViewModel: NSObject, ObservableObject {
    @Published var socialLoginInfo = SocialLoginInfo()
    @AppStorage("idToken") private var idToken = ""
    
    func handleAppleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    func handleKakaoLogin() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print("🍀",error)
                }
                if let oauthToken = oauthToken{
                    if let idToken = oauthToken.idToken {
                        self.updateLoginModel(platform: "kakao", idToken: idToken, name: "")
                    }
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print("🍀",error)
                }
                if let oauthToken = oauthToken{
                    print("kakao success")
                }
            }
        }
    }
    
    func updateLoginModel(platform: String, idToken: String, name: String) {
        socialLoginInfo = SocialLoginInfo(platform: platform, idToken: idToken, name: name)
        self.idToken = idToken
    }
}

extension LoginViewModel: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            handleAppleIDCredential(appleIDCredential)
        default:
            break
        }
    }
    
    func handleAppleIDCredential(_ credential: ASAuthorizationAppleIDCredential) {
        let userIdentifier = credential.user
        let fullName = credential.fullName
        let name = (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
        guard let idToken = String(data: credential.identityToken ?? Data(), encoding: .utf8) else { return print("no idToken!!") }
        
        self.updateLoginModel(platform: "apple", idToken: idToken, name: name)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}
