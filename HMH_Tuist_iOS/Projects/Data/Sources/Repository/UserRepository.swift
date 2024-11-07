//
//  UserRepository.swift
//  Data
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

public struct UserRepository: UserRepositoryType {
    private let service: UserServiceType
    
    public init(service: UserServiceType) {
        self.service = service
    }
    
    public func logout() -> AnyPublisher<Void, UserError> {
        service.logout()
            .map { _ in () }
            .mapToDomainError(to: UserError.self)
    }
    
    public func deleteAccount() -> AnyPublisher<Void, UserError> {
        service.deleteAccount()
            .map { _ in () }
            .mapToDomainError(to: UserError.self)
    }
    
    public func getUserData() -> AnyPublisher<User, UserError> {
        service.getUserData()
            .map { $0.toEntity() }
            .mapToDomainError(to: UserError.self)
    }
    
    public func getCurrentPoint() -> AnyPublisher<Int, UserError> {
        service.getCurrentPoint()
            .map {$0.point}
            .mapToDomainError(to: UserError.self)
    }
}

