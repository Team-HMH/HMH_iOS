//
//  GetUserMockData.swift
//  Data
//
//  Created by 류희재 on 11/5/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension User {
    static public var expectedData: [User] {
        return [
            .init(name: "류희재", point: 100),
            .init(name: "류희재", point: -100),
            .init(name: "류희재", point: 0),
            .init(name: "류희재", point: Int.max),
            .init(name: "류희재", point: Int.min)
        ]
    }
}

extension UserResult {
    static public var resultData: [UserResult] {
        return [
            .init(name: "류희재", point: 100),
            .init(name: "류희재", point: -100),
            .init(name: "류희재", point: 0),
            .init(name: "류희재", point: Int.max),
            .init(name: "류희재", point: Int.min)
        ]
    }
}
