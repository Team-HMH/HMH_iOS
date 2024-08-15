//
//  AuthAPI.swift
//  MyPageFeatureInterface
//
//  Created by 류희재 on 8/13/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Moya
import Domain

enum AuthAPI {
    case revoke
    case logout
}

extension AuthAPI: BaseAPI {
    public static var apiType: APIType = .auth
    
    var path: String {
        switch self {
        case .revoke:
            return "user"
        case .logout:
            return "user/logout"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .revoke:
            return .delete
        case .logout:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .revoke:
            return .requestPlain
        case .logout:
            return .requestPlain
        }
    }
    
    var validationType: ValidationType {
        switch self {
        case .revoke:
            return .successCodes
        case .logout:
            return .successCodes
        }
    }
}
