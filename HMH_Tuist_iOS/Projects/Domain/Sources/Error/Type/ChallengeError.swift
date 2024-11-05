//
//  ChallengeError.swift
//  Domain
//
//  Created by 류희재 on 11/4/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

public enum ChallengeError: DomainError {
    case challengeNotFound
    case challengePeriodIsNil
    case invalidChallengePeriod
    case goalTimeIsNil
    case invalidGoalTime
    case networkError
    
    public static func error(with message: String) -> ChallengeError {
        switch message {
        case "챌린지를 찾을 수 없습니다.":
            return .challengeNotFound
        case "목표시간은 null일 수 없습니다.":
            return .challengePeriodIsNil
        case "유효한 숫자의 챌린지 기간을 입력해주세요.":
            return .invalidChallengePeriod
        case "챌린지 기간은 null일 수 없습니다.":
            return .goalTimeIsNil
        case "유효한 숫자의 목표 시간을 입력해주세요.":
            return .invalidGoalTime
        default:
            return .networkError
        }
    }
}
