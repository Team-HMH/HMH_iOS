//
//  MockOAuthServiceFactory.swift
//  Data
//
//  Created by 류희재 on 11/6/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks
import Data

public class MockOAuthServiceFactory: OAuthServiceFactoryType {
    public var service: OAuthServiceType!
    
    public init() {}
    
    public func makeOAuthService(for providerType: OAuthProviderType) -> OAuthServiceType {
        return service
    }
}

final public class MockOAuthKakaoService: OAuthServiceType {
    
    public init() {}
    
    public var authorizeResult:AnyPublisher<String, HMHNetworkError>!
    
    public func authorize() -> AnyPublisher<String, HMHNetworkError> {
        return authorizeResult
    }
}

final public class MockOAuthAppleService: OAuthServiceType {
    
    public init() {}
    
    public var authorizeResult:AnyPublisher<String, HMHNetworkError>!
    
    public func authorize() -> AnyPublisher<String, HMHNetworkError> {
        return authorizeResult
    }
}
