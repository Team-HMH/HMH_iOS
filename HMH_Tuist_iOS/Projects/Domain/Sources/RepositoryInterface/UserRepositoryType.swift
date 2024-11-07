//
//  UserRepositoryType.swift
//  Domain
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol UserRepositoryType {
    func logout() -> AnyPublisher<Void, UserError>
    func deleteAccount() -> AnyPublisher<Void, UserError>
    func getUserData() -> AnyPublisher<User, UserError>
    func getCurrentPoint() -> AnyPublisher<Int, UserError>
}
