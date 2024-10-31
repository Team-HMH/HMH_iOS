//
//  ASAuthorizationControllerProxy.swift
//  Networks
//
//  Created by 류희재 on 10/31/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Combine
import AuthenticationServices

//extension ASAuthorizationController: HasDelegate {
//    public typealias Delegate = ASAuthorizationControllerDelegate
//}

class ASAuthorizationControllerProxy: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    // Combine Subject를 사용해 이벤트를 전달합니다.
    var didCompleteAuthorization = PassthroughSubject<ASAuthorization, Never>()
    var didCompleteWithError = PassthroughSubject<Error, Never>()
    
    private var presentationWindow: UIWindow

    init(presentationWindow: UIWindow) {
        self.presentationWindow = presentationWindow
    }
    
    // ASAuthorizationControllerDelegate 메서드를 통해 결과를 Subject로 전송합니다.
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        didCompleteAuthorization.send(authorization)
        didCompleteAuthorization.send(completion: .finished)
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        didCompleteWithError.send(error)
        didCompleteWithError.send(completion: .finished)
    }
    
    // ASAuthorizationControllerPresentationContextProviding 메서드
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return presentationWindow
    }
}
