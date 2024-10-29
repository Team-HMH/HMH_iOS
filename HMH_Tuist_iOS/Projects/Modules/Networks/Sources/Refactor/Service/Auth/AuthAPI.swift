//
//  AuthAPI.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Domain

enum AuthAPI {
    case signUp(request: SignUpRequest)
    case socialLogin(request: SocialLoginRequest)
    case tokeRefresh
}

extension AuthAPI: BaseAPI {
    var isWithInterceptor: Bool {
        return false
    }
    
    var path: String? {
        switch self {
        case .signUp:
            return Paths.signUp
        case .socialLogin:
            return Paths.socialLogin
        case .tokeRefresh:
            return Paths.tokenRefresh
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .signUp:
            return .post
        case .socialLogin:
            return .post
        case .tokeRefresh:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .signUp(let request):
            return .requestJSONEncodable(request)
        case .socialLogin(let request):
            return .requestJSONEncodable(request)
        case .tokeRefresh:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .signUp:
            return APIHeaders.signUpHeader
        case .socialLogin:
            return APIHeaders.hasSocialTokenHeader
        case .tokeRefresh:
            return APIHeaders.hasRefreshTokenHeader
        }
    }
}

