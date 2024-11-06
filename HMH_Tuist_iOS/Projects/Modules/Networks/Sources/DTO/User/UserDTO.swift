//
//  UserDTO.swift
//  Networks
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct UserResult: Decodable {
    public let name: String
    public let point: Int
    
    public init(name: String, point: Int) {
        self.name = name
        self.point = point
    }
}

extension UserResult {
    static var stub: Self {
        .init(name: "류희재", point: 1000)
    }
}


