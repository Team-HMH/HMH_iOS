//
//  UserError.swift
//  Domain
//
//  Created by 류희재 on 11/4/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

public enum UserError: DomainError {
    case noSignUpInfo
    case alreadyRegisteredUser
    case unregisteredUser
    case unknown
    
    public static func error(with message: String) -> UserError {
        switch message {
        case "온보딩 정보 또는 챌린지 정보 없음":
            return .noSignUpInfo
        case "이미 회원가입된 유저입니다.":
            return .alreadyRegisteredUser
        case "회원가입된 유저가 아닙니다. 회원가입을 진행해주세요.":
            return .unregisteredUser
        default:
            return .unknown
        }
    }
}


