//
//  AppleLoginManager.swift
//  Networks
//
//  Created by 류희재 on 10/31/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import AuthenticationServices
import Combine

/// 애플 로그인 매니저
final class AppleLoginManager: NSObject {
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
    }
    
    // 로그인 버튼 클릭 시 로직 수행 (request를 보내줄 controller를 생성)
    func handleAuthorizationAppleIDButtonPress() -> AnyPublisher<ASAuthorization, Never> {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        let proxy = ASAuthorizationControllerProxy(presentationWindow: UIWindow())
        
        authorizationController.delegate = proxy
        authorizationController.presentationContextProvider = proxy
        authorizationController.performRequests()
        
        // Combine을 사용하여 로그인 완료 시점의 스트림을 반환
        return proxy.didCompleteAuthorization.eraseToAnyPublisher()
    }
    
    // 애플 로그인 상태 확인
    static func getCredentialState(completion: ((ASAuthorizationAppleIDProvider.CredentialState) -> Void)? = nil) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        
        // TODO: 이후에 UserID 가져와서 체크 <- 언제쓴거지?(24.03.18)
        appleIDProvider.getCredentialState(forUserID: "") { (credentialState, error) in
            switch credentialState {
            case .authorized:
                print("The Apple ID credential is valid.")
                break
            
            case .revoked:
                print("The Apple ID credential is revoked. need logout progress.")
                completion?(credentialState)
                break
                
            case .notFound:
                print("User identifier value is wrong or Apple login system has a problem.")
                completion?(credentialState)
                break
            default:
                break
            }
        }
    }
}
