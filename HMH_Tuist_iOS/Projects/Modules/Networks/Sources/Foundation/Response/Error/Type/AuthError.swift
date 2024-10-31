//
//  AuthError.swift
//  Networks
//
//  Created by 류희재 on 10/31/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

extension HMHNetworkError {
    public enum AuthError: Error {
        case kakaoLoginError
        case appleLoginError
        
        var description: String {
            switch self {
            case .kakaoLoginError:
                return "카카오 로그인 시도 중 생긴 oauth 오류입니다"
            case .appleLoginError:
                return "애플 로그인 시도 중 생긴 oauth 오류입니다"
            }
        }
    }
}
