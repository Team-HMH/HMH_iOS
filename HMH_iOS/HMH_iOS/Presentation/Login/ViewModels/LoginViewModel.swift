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
    @AppStorage("acessToken") private var acessToken = ""
    @AppStorage("refreshToken") private var refreshToken = ""
    @AppStorage("socialToken") private var socialToken = ""
    
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
                        self.updateLoginModel(platform: "KAKAO", idToken: idToken, name: "")
                        self.getSocialLoginData()
                        
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
        self.socialToken = "Bearer " + idToken
    }
    
    func getSocialLoginData() {
        let provider = Providers.AuthProvider
        let request = SocialLoginRequestDTO(socialPlatform: "KAKAO")
        
        provider.request(target: .socialLogin(data: request), instance: BaseResponse<SocialLogineResponseDTO>.self) { data in
            if data.status == 403 {
                @AppStorage("isOnboarding") var isOnboarding : Bool = false
            } else if data.status == 200 {
                guard let data = data.data else { return }
//                UserManager.shared.updateToken(data.token.accessToken, data.token.refreshToken)
//                UserManager.shared.updateUserId(data.userId)
            }
        }
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
     
        self.updateLoginModel(platform: "APPLE", idToken: idToken, name: name)
        print(idToken)
        self.socialToken = idToken
        //성공 시 수행할 api 로직
        self.getSocialLoginData()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}
