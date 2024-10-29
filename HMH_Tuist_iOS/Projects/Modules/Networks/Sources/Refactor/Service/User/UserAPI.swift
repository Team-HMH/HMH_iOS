//
//  UserAPI.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Domain

enum UserAPI {
    case logout
    case deleteAccount
    case getUserData
    case getCurrentPoint
}

extension UserAPI: BaseAPI {
    var isWithInterceptor: Bool {
        return false
    }
    
    var path: String? {
        switch self {
        case .logout:
            return Paths.logout
        case .deleteAccount:
            return Paths.deleteAccount
        case .getUserData:
            return Paths.getUserData
        case .getCurrentPoint:
            return Paths.getCurrentPoint
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .logout:
            return .post
        case .deleteAccount:
            return .delete
        case .getUserData:
            return .get
        case .getCurrentPoint:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .logout:
            return .requestPlain
        case .deleteAccount:
            return .requestPlain
        case .getUserData:
            return .requestPlain
        case .getCurrentPoint:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .logout:
            return APIHeaders.hasTokenHeader
        case .deleteAccount:
            return APIHeaders.hasTokenHeader
        case .getUserData:
            return APIHeaders.hasTokenHeader
        case .getCurrentPoint:
            return APIHeaders.hasAccessTokenHeader
        }
    }
}
