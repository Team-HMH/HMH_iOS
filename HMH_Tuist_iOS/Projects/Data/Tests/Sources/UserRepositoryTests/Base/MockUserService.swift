//
//  MockUserService.swift
//  Data
//
//  Created by 류희재 on 11/5/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

final public class MockUserService: UserServiceType {
    
    public init() {}
    
    public var logoutResult:AnyPublisher<Void, HMHNetworkError>!
    public var deleteAccountResult: AnyPublisher<Void, HMHNetworkError>!
    public var getUserDataResult: AnyPublisher<UserResult, HMHNetworkError>!
    public var getCurrentPointResult: AnyPublisher<PointResult, HMHNetworkError>!
    
    
    public func logout() -> AnyPublisher<Void, HMHNetworkError> {
        return logoutResult
    }
    
    public func deleteAccount() -> AnyPublisher<Void, HMHNetworkError> {
        return deleteAccountResult
    }
    
    public func getUserData() -> AnyPublisher<UserResult, HMHNetworkError> {
        return getUserDataResult
    }
    
    public func getCurrentPoint() -> AnyPublisher<PointResult, Networks.HMHNetworkError> {
        return getCurrentPointResult
    }
}
