//
//  ChallengeAPI.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

enum ChallengeAPI {
    case getdailyChallenge
    case getSuccesChallenge
    case createChallenge(request: CreateChallengeRequest)
    case getLockChallenge
    case postLockChallenge
    case deleteApp(request: DeleteAppRequest)
    case addApp(request: AddAppRequest)
    case getChallenge
}

extension ChallengeAPI: BaseAPI {
    var isWithInterceptor: Bool {
        return true
    }
    
    var path: String? {
        switch self {
        case .getdailyChallenge:
            return Paths.getChallenge
        case .getSuccesChallenge:
            return Paths.getSuccesChallenge
        case .createChallenge:
            return Paths.createChallenge
        case .getLockChallenge:
            return Paths.getLockChallenge
        case .postLockChallenge:
            return Paths.postLockChallenge
        case .deleteApp:
            return Paths.deleteApp
        case .addApp:
            return Paths.addApp
        case .getChallenge:
            return Paths.getChallenge
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getdailyChallenge:
            return .get
        case .getSuccesChallenge:
            return .get
        case .createChallenge:
            return .post
        case .getLockChallenge:
            return .get
        case .postLockChallenge:
            return .post
        case .deleteApp:
            return .delete
        case .addApp:
            return .post
        case .getChallenge:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getdailyChallenge:
            return .requestPlain
        case .getSuccesChallenge:
            return .requestPlain
        case .createChallenge(let request):
            return .requestJSONEncodable(request)
        case .getLockChallenge:
            return .requestPlain
        case .postLockChallenge:
            return .requestPlain
        case .deleteApp(let request):
            return .requestJSONEncodable(request)
        case .addApp(let request):
            return .requestJSONEncodable(request)
        case .getChallenge:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return APIHeaders.hasTokenHeader
    }
}

