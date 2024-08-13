//
//  UserAPI.swift
//  MyPageFeatureInterface
//
//  Created by 류희재 on 8/13/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Moya
import Networks

enum UserAPI {
    case getUserData
}

extension UserAPI: BaseAPI {
    public static var apiType: APIType = .user

    var headers: [String : String]? {
        switch self {
        case .getUserData:
            return ["Content-Type": "application/json",
                    "OS": "iOS",
                    "auth": ""]
        }
    }
    
    var path: String {
        switch self {
        case .getUserData:
            return "user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserData:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getUserData:
            return .requestPlain
        }
    }
}

