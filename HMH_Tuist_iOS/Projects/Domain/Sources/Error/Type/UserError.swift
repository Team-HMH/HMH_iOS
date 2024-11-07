//
//  UserError.swift
//  Domain
//
//  Created by 류희재 on 11/4/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

public enum UserError: DomainError {
    case userNotFound
    case networkError
    
    public static func error(with message: String) -> UserError {
        switch message {
        case "존재하지 않는 유저":
            return .userNotFound
        default:
            return .networkError
        }
    }
}


