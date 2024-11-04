//
//  DomainError.swift
//  Domain
//
//  Created by 류희재 on 11/4/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public protocol DomainError: Error {
    static func error(with message: String) -> Self
}
