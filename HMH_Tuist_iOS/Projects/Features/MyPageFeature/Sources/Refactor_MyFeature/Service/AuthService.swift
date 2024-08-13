//
//  AuthService.swift
//  MyPageFeatureInterface
//
//  Created by 류희재 on 8/13/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

protocol AuthServiceType {
    func revokeUser()
    func logoutUser()
}

class AuthService: AuthServiceType {
    func revokeUser() {}
    func logoutUser() {}
}

class StubAuthService: AuthServiceType {
    func revokeUser() {}
    func logoutUser() {}
}
