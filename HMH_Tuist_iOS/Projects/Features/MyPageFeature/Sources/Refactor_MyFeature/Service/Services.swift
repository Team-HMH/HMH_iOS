//
//  Services.swift
//  MyPageFeatureInterface
//
//  Created by 류희재 on 8/13/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

protocol ServiceType {
    var authService: AuthenticationServiceType { get set }
    var userService: UserServiceType { get set }
}

class Services: ServiceType {
    var authService: AuthenticationServiceType
    var userService: UserServiceType
    
    init() {
        self.authService = AuthenticationService()
        self.userService = UserService(dbRepository: UserDBRepository())
    }
}

class StubService: ServiceType {
    var authService: AuthenticationServiceType = StubAuthenticationService()
    var userService: UserServiceType = StubUserService()
}

