//
//  User.swift
//  Domain
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct User {
    let name: String
    let point: Int
    
    public init(name: String, point: Int) {
        self.name = name
        self.point = point
    }
}
