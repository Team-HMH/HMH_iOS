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
    func logout() -> AnyPublisher<Void, HMHNetworkError>
    func deleteAccount() -> AnyPublisher<Void, HMHNetworkError>
    func getUserData() -> AnyPublisher<UserResult, HMHNetworkError>
    func getCurrentPoint() -> AnyPublisher<PointResult, HMHNetworkError>
}

extension UserService: UserServiceType {
    func logout() -> AnyPublisher<Void, HMHNetworkError> {
        requestWithNoResult(.logout)
    }
    
    func deleteAccount() -> AnyPublisher<Void, HMHNetworkError> {
        requestWithNoResult(.deleteAccount)
    }
    
    func getUserData() -> AnyPublisher<UserResult, HMHNetworkError> {
        requestWithResult(.getUserData, UserResult.self)
    }
    
    func getCurrentPoint() -> AnyPublisher<PointResult, HMHNetworkError> {
        requestWithResult(.getCurrentPoint, PointResult.self)
    }
}

struct StubUserService: UserServiceType {
    func logout() -> AnyPublisher<Void, HMHNetworkError> {
        return Just(())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func deleteAccount() -> AnyPublisher<Void, HMHNetworkError> {
        return Just(())
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

