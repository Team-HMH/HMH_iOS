//
//  PointError.swift
//  Domain
//
//  Created by 류희재 on 11/4/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public enum PointError: DomainError {
    case insufficientPoints
    case userNotFound
    case challengeNotFound
    case alreadyEarnedPoints
    case challengeNotSuccessful
    case unknown
    
    public static func error(with message: String) -> PointError {
        switch message {
        case "포인트가 부족합니다.":
            return .insufficientPoints
        case "존재하지 않는 유저":
            return .userNotFound
        case "챌린지를 찾을 수 없습니다.":
            return .challengeNotFound
        case "이전 요청에서 이미 포인트를 받은 챌린지":
            return .alreadyEarnedPoints
        case "성공하지 않은 챌린지":
            return .challengeNotSuccessful
        default:
            return .unknown
        }
    }
}

