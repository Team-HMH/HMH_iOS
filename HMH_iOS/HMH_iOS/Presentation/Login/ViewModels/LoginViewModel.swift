import SwiftUI
import AuthenticationServices

import KakaoSDKUser

class LoginViewModel: NSObject, ObservableObject {
    
    @Published var isLoading: Bool = true
    
    func handleSplashScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refreshToken()
            self.isLoading = false
        }
    }
    
    private func refreshToken() {
        let provider = Providers.AuthProvider
        provider.request(target: .tokenRefresh, instance: BaseResponse<RefreshTokebResponseDTO>.self) { data in
            if let data = data.data {
                UserManager.shared.accessToken = data.token.accessToken
                UserManager.shared.refreshToken = data.token.accessToken
            }
        }
    }
    
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
                    print(error)
                }
                if let oauthToken = oauthToken{
                    let idToken = oauthToken.accessToken
                    UserManager.shared.socialPlatform = "KAKAO"
                    UserManager.shared.socialToken = "Bearer " + idToken
                    self.postSocialLoginData()
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print("🍀",error)
                }
                if let oauthToken = oauthToken{
                    print("kakao success")
                    UserManager.shared.socialPlatform = "KAKAO"
                    let idToken = oauthToken.refreshToken
                    UserManager.shared.socialToken = "Bearer " + idToken
                    self.postSocialLoginData()
                }
            }
        }
    }
    
    func postSocialLoginData() {
        let provider = Providers.AuthProvider
        let request = SocialLoginRequestDTO(socialPlatform: UserManager.shared.socialPlatform ?? "")
        
        provider.request(target: .socialLogin(data: request), instance: BaseResponse<SocialLogineResponseDTO>.self) { data in
            if data.status == 403 {
                UserManager.shared.isOnboarding = false
            } else if data.status == 200 {
                guard let data = data.data else { return }
                UserManager.shared.isLogin = true
                UserManager.shared.refreshToken = data.token.refreshToken
                UserManager.shared.accessToken = data.token.accessToken
            }
        }
    }
}

extension LoginViewModel: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            
            if  let identityToken = appleIDCredential.identityToken,
                let identifyTokenString = String(data: identityToken, encoding: .utf8) {
                if let unwrappedFullName = fullName, let givenName = unwrappedFullName.givenName, let familyName = unwrappedFullName.familyName {
                } else {
                    print("fullName이 없거나 givenName 또는 familyName이 없습니다.")
                }
                UserManager.shared.socialToken = identifyTokenString
            }
            UserManager.shared.socialPlatform = "APPLE"
            self.postSocialLoginData()
        default:
            break
        }
    }
    
    func handleAppleIDCredential(_ credential: ASAuthorizationAppleIDCredential) {
        let userIdentifier = credential.user
        let fullName = credential.fullName
        let name = (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
        UserManager.shared.userName = name
        guard let idToken = String(data: credential.identityToken ?? Data(), encoding: .utf8) else { return print("no idToken!!") }
        
        UserManager.shared.socialToken = idToken
        UserManager.shared.socialPlatform = "APPLE"
        self.postSocialLoginData()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}
