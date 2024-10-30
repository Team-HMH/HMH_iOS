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

typealias UserService = BaseService<UserAPI>

public protocol UserServiceType {
    func logout() -> AnyPublisher<VoidResult, HMHNetworkError>
    func deleteAccount() -> AnyPublisher<VoidResult, HMHNetworkError>
    func getUserData() -> AnyPublisher<UserResult, HMHNetworkError>
    func getCurrentPoint() -> AnyPublisher<PointResult, HMHNetworkError>
}

extension UserService: UserServiceType {
    public func logout() -> AnyPublisher<VoidResult, HMHNetworkError> {
        sendRequest(.logout)
    }
    
    public func deleteAccount() -> AnyPublisher<VoidResult, HMHNetworkError> {
        sendRequest(.deleteAccount)
    }
    
    public func getUserData() -> AnyPublisher<UserResult, HMHNetworkError> {
        sendRequest(.getUserData)
    }
    
    public func getCurrentPoint() -> AnyPublisher<PointResult, HMHNetworkError> {
        sendRequest(.getCurrentPoint)
    }
}

struct StubUserService: UserServiceType {
    func logout() -> AnyPublisher<VoidResult, HMHNetworkError> {
        return Just(VoidResult())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func deleteAccount() -> AnyPublisher<VoidResult, HMHNetworkError> {
        return Just(VoidResult())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func getUserData() -> AnyPublisher<UserResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func getCurrentPoint() -> AnyPublisher<PointResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
}

