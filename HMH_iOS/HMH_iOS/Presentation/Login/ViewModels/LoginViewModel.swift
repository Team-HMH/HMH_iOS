import SwiftUI
import AuthenticationServices
import KakaoSDKUser

class LoginViewModel: NSObject, ObservableObject {
    @Published var socialLoginInfo = SocialLoginInfo()
    @AppStorage("idToken") private var idToken = ""
    @AppStorage("acessToken") private var acessToken = ""
    @AppStorage("refreshToken") private var refreshToken = ""
    @AppStorage("socialToken") private var socialToken = ""
    @AppStorage("socialPlatform") private var socialPlatform = ""
    @AppStorage("isOnboarding") var isOnboarding : Bool?
    @AppStorage("isLogIn") var isLoggedIn : Bool?
    
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
                    let idToken = oauthToken.accessToken
                    self.socialPlatform = "KAKAO"
                    self.socialToken = "Bearer " + idToken
                    self.getSocialLoginData()
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print("🍀",error)
                }
                if let oauthToken = oauthToken{
                    print("kakao success")
                    self.socialPlatform = "KAKAO"
                    let idToken = oauthToken.refreshToken
                    self.socialToken = "Bearer" + idToken
                    self.getSocialLoginData()
                }
            }
        }
    }
    
    func getSocialLoginData() {
        let provider = Providers.AuthProvider
        let request = SocialLoginRequestDTO(socialPlatform: socialPlatform)
        
        provider.request(target: .socialLogin(data: request), instance: BaseResponse<SocialLogineResponseDTO>.self) { data in
            DispatchQueue.main.async {
                if data.status == 403 {
                    self.isOnboarding = true
                    self.isLoggedIn = false
                } else if data.status == 200 {
                    guard let data = data.data else { return }
                    self.isOnboarding = true
                    self.isLoggedIn = true
                    self.idToken = data.token.accessToken
                    self.refreshToken = data.token.refreshToken
                    // UserManager.shared.updateToken(data.token.accessToken, data.token.refreshToken)
                    // UserManager.shared.updateUserId(data.userId)
                }
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
                    // UserManager.shared.updateUserName(givenName, familyName)
                } else {
                    print("fullName이 없거나 givenName 또는 familyName이 없습니다.")
                }
                
                // UserManager.shared.updateAppleToken(identifyTokenString)
                // UserManager.shared.updateUserIdentifier(userIdentifier)
                self.socialToken = identifyTokenString
            }

            self.socialPlatform = "APPLE"
            self.getSocialLoginData()
        default:
            break
        }

    }
    
    func handleAppleIDCredential(_ credential: ASAuthorizationAppleIDCredential) {
        let userIdentifier = credential.user
        let fullName = credential.fullName
        let name = (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
        guard let idToken = String(data: credential.identityToken ?? Data(), encoding: .utf8) else { return print("no idToken!!") }
     
        self.socialToken = idToken
        self.socialPlatform = "APPLE"
        //성공 시 수행할 api 로직
        self.getSocialLoginData()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}
