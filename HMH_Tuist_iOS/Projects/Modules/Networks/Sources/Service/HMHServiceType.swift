//
//  HMHServiceType.swift
//  NetworksDemo
//
//  Created by 류희재 on 11/24/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public protocol HMHServiceType {
    var authService: AuthServiceType { get }
    var challengeService: ChallengeServiceType { get }
    var pointService: PointServiceType { get }
    var userService: UserServiceType { get }
}

final public class HMHService: HMHServiceType {
    public init() {}
    public var authService: AuthServiceType = AuthService()
    public var challengeService: ChallengeServiceType = ChallengeService()
    public var pointService: PointServiceType = PointService()
    public var userService: UserServiceType = UserService()
}

final public class StubHMHService: HMHServiceType {
    public init() {}
    public var authService: AuthServiceType = StubAuthService()
    public var challengeService: ChallengeServiceType = StubChallengeService()
    public var pointService: PointServiceType = StubPointService()
    public var userService: UserServiceType = StubUserService()
}
