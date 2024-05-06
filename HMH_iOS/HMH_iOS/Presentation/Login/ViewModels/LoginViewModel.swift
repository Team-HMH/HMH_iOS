//
//  LoginViewModel.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/5/24.
//

import SwiftUI
import AuthenticationServices

class LoginViewModel: NSObject, ObservableObject {
    @Published var appleLoginInfo = AppleLoginInfo()

    func handleAppleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    func handleKakaoLogin() {
        
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
//        let fullName = credential.fullName
//        let name = (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
//        let email = credential.email
//        let identityToken = String(data: credential.identityToken ?? Data(), encoding: .utf8)
//        let authorizationCode = String(data: credential.authorizationCode ?? Data(), encoding: .utf8)

        appleLoginInfo = AppleLoginInfo(token: userIdentifier)
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}
