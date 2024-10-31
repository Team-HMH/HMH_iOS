//
//  OAuthAppleService.swift
//  Networks
//
//  Created by 류희재 on 10/31/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import AuthenticationServices
import Combine

final class OAuthAppleService: OAuthServiceType {
    
    private var cancellables = Set<AnyCancellable>()
    private let appleLoginManager = AppleLoginManager()
    
    func authorize() -> AnyPublisher<String, HMHNetworkError.AuthError> {
        return login()
            .map { $0.0 }
            .eraseToAnyPublisher()
    }
    
    private func login() -> Future<(String, String?), HMHNetworkError.AuthError> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            
            self.appleLoginManager
                .handleAuthorizationAppleIDButtonPress()
                .sink(
                    receiveCompletion: { completion in
                        if case .failure = completion {
                            promise(.failure(.appleLoginError))
                        }
                    },
                    receiveValue: { result in
                        guard
                            let credential = result.credential as? ASAuthorizationAppleIDCredential,
                            let idToken = credential.identityToken,
                            let idTokenString = String(data: idToken, encoding: .utf8)
                        else {
                            promise(.failure(.appleLoginError))
                            return
                        }
                        
                        var name: String? = nil
                        
                        if let fullName = credential.fullName,
                           let familyName = fullName.familyName,
                           let givenName = fullName.givenName {
                            name = familyName + givenName
//                            KeychainManager.saveUsername(name)
                        }
                        
                        promise(.success((idTokenString, name)))
                    }
                )
                .store(in: &self.cancellables)
        }
    }
}

