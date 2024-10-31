//
//  UserAPI.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Domain

public enum UserAPI {
    case logout
    case deleteAccount
    case getUserData
    case getCurrentPoint
}

extension UserAPI: BaseAPI {
    public var isWithInterceptor: Bool {
        return false
    }
    
    public var path: String? {
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
    
    public var method: HTTPMethod {
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
    
    public var task: Task {
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
    
    public var headers: [String : String]? {
        return APIHeaders.hasTokenHeader
    }
}
