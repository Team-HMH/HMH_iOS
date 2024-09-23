//
//  AuthService.swift
//  MyPageFeatureInterface
//
//  Created by 류희재 on 8/13/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain

typealias DefaultAuthService = BaseService<AuthAPI>

protocol AuthServiceType {
    func revokeUser() -> AnyPublisher<EmptyResponseDTO, Error>
    func logoutUser() -> AnyPublisher<EmptyResponseDTO, Error>
}

extension DefaultAuthService: AuthServiceType {
    func revokeUser() -> AnyPublisher<Domain.EmptyResponseDTO, any Error> {
        return requestObjectWithNetworkErrorInCombine(.revoke)
    }
    
    func logoutUser() -> AnyPublisher<Domain.EmptyResponseDTO, any Error> {
        return requestObjectWithNetworkErrorInCombine(.logout)
    }
}

class StubAuthService: AuthServiceType {
    func revokeUser() -> AnyPublisher<EmptyResponseDTO, Error> {
        Empty().eraseToAnyPublisher()
    }
    
    func logoutUser() -> AnyPublisher<EmptyResponseDTO, Error>  {
        Empty().eraseToAnyPublisher()
    }
}
