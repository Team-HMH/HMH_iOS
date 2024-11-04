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
    
    init(service: UserServiceType) {
        self.service = service
    }
    
    public func logout() -> AnyPublisher<Void, Error> {
        service.logout()
            .asVoidWithGeneralError()
    }
    
    public func deleteAccount() -> AnyPublisher<Void, Error> {
        service.deleteAccount()
            .asVoidWithGeneralError()
    }
    
    public func getUserData() -> AnyPublisher<User, Error> {
        service.getUserData()
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    public func getCurrentPoint() -> AnyPublisher<Int, Error> {
        service.getCurrentPoint()
            .map {$0.point}
            .mapToGeneralError()
    }
}

