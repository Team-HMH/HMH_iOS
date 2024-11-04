//
//  OAuthSerivce.swift
//  Networks
//
//  Created by 류희재 on 10/31/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol OAuthServiceType {
    func authorize() -> AnyPublisher<String, HMHNetworkError.AuthrizationError>
}

final class OAuthSerivce: OAuthServiceType {
    func authorize() -> AnyPublisher<String, HMHNetworkError.AuthrizationError> {
        return Just("")
            .setFailureType(to: HMHNetworkError.AuthrizationError.self)
            .eraseToAnyPublisher()
    }
}

final class StubOAuthService: OAuthServiceType {
    func authorize() -> AnyPublisher<String, HMHNetworkError.AuthrizationError> {
        return Just("")
            .setFailureType(to: HMHNetworkError.AuthrizationError.self)
            .eraseToAnyPublisher()
    }

}
