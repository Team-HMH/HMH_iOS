//
//  UserService.swift
//  MyPageFeatureInterface
//
//  Created by 류희재 on 8/13/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

protocol UserServiceType {
    func getUserData()
}

class UserService: UserServiceType {
    func getUserData() {}
}

class StubUserService: UserServiceType {
    func getUserData() {}
}
