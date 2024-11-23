//
//  HMHServiceType.swift
//  NetworksDemo
//
//  Created by 류희재 on 11/24/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Networks


protocol HMHServiceType {
    var authService: AuthServiceType { get }
    var challengeService: ChallengeServiceType { get }
    var pointService: PointServiceType { get }
    var userService: UserServiceType { get }
}

final class HMHService: HMHServiceType {
    var authService: AuthServiceType = AuthService()
    var challengeService: ChallengeServiceType = ChallengeService()
    var pointService: PointServiceType = PointService()
    var userService: UserServiceType = UserService()
}

final class StubHMHSerivce: HMHServiceType {
    var authService: AuthServiceType = StubAuthService()
    var challengeService: ChallengeServiceType = StubChallengeService()
    var pointService: PointServiceType = StubPointService()
    var userService: UserServiceType = StubUserService()
}
