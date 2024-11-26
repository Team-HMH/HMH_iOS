//
//  UserService.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

public typealias UserService = BaseService<UserAPI>

public protocol UserServiceType {
    func logout() -> AnyPublisher<Void, HMHNetworkError>
    func deleteAccount() -> AnyPublisher<Void, HMHNetworkError>
    func getUserData() -> AnyPublisher<UserResult, HMHNetworkError>
    func getCurrentPoint() -> AnyPublisher<PointResult, HMHNetworkError>
}

extension UserService: UserServiceType {
    public func logout() -> AnyPublisher<Void, HMHNetworkError> {
        requestWithNoResult(.logout)
    }
    
    public func deleteAccount() -> AnyPublisher<Void, HMHNetworkError> {
        requestWithNoResult(.deleteAccount)
    }
    
    public func getUserData() -> AnyPublisher<UserResult, HMHNetworkError> {
        requestWithResult(.getUserData)
    }
    
    public func getCurrentPoint() -> AnyPublisher<PointResult, HMHNetworkError> {
        requestWithResult(.getCurrentPoint)
    }
}

public struct StubUserService: UserServiceType {
    public init() {}
    
    public func logout() -> AnyPublisher<Void, HMHNetworkError> {
        return Just(())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    public func deleteAccount() -> AnyPublisher<Void, HMHNetworkError> {
        return Just(())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    public func getUserData() -> AnyPublisher<UserResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    public func getCurrentPoint() -> AnyPublisher<PointResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
}

