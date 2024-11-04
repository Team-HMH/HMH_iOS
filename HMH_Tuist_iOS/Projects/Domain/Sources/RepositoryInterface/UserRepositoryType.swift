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
    func logout() -> AnyPublisher<Void, Error>
    func deleteAccount() -> AnyPublisher<Void, Error>
    func getUserData() -> AnyPublisher<User, Error>
    func getCurrentPoint() -> AnyPublisher<Int, Error>
}
