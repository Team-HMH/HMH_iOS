//
//  ChallengeAPI.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public enum ChallengeAPI {
    case getdailyChallenge
    case postSuccesChallenge
    case createChallenge(request: CreateChallengeRequest)
    case getLockChallenge
    case postLockChallenge
    case deleteApp(request: DeleteAppRequest)
    case addApp(request: AddAppRequest)
    case getChallenge
}

extension ChallengeAPI: BaseAPI {
    public var isWithInterceptor: Bool {
        return true
    }
    
    public var path: String? {
        switch self {
        case .getdailyChallenge:
            return Paths.getdailyChallenge
        case .postSuccesChallenge:
            return Paths.postSuccesChallenge
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
    
    public var method: HTTPMethod {
        switch self {
        case .getdailyChallenge:
            return .get
        case .postSuccesChallenge:
            return .post
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
    
    public var task: Task {
        switch self {
        case .getdailyChallenge:
            return .requestPlain
        case .postSuccesChallenge:
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
    
    public var headers: [String : String]? {
        switch self {
        case .getdailyChallenge:
            return APIHeaders.hasTokenWithTimeZoneHeader
        case .postSuccesChallenge:
            return APIHeaders.hasTokenWithTimeZoneHeader //안되면 contenttype 빼고
        case .createChallenge:
            return APIHeaders.hasTokenWithAllHeader
        case .getLockChallenge:
            return APIHeaders.hasTokenWithTimeZoneHeader
        case .postLockChallenge:
            return APIHeaders.hasTokenWithTimeZoneHeader
        case .deleteApp:
            return APIHeaders.hasTokenWithTimeZoneHeader
        case .addApp:
            return APIHeaders.hasTokenWithOSHeader
        case .getChallenge:
            return APIHeaders.hasTokenWithAllHeader
        }
    }
}

