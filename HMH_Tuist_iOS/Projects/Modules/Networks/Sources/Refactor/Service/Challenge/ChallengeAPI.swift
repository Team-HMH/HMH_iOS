//
//  ChallengeAPI.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Domain

enum ChallengeAPI {
    case createChallenge(data: CreateChallengeRequestDTO)
    case dailyChallengeFail
    case getChallenge
    case getdailyChallenge
    case addApp(data: AddAppRequestDTO)
    case deleteApp(data: DeleteAppRequestDTO)
    case postDailyChallenge(data: MidnightRequestDTO)
}

extension ChallengeAPI: BaseAPI {
    var isWithInterceptor: Bool {
        return true
    }
    
    var path: String? {
        switch self {
        case .createChallenge:
            return Paths.createChallenge
        case .dailyChallengeFail:
            return Paths.dailyChallengeFail
        case .getChallenge:
            return Paths.getChallenge
        case .getdailyChallenge:
            return Paths.getChallenge
        case .addApp:
            return Paths.addApp
        case .deleteApp:
            return Paths.deleteApp
        case .postDailyChallenge:
            return Paths.postDailyChallenge
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .createChallenge:
            return .post
        case .dailyChallengeFail:
            return .patch
        case .getChallenge:
            return .get
        case .getdailyChallenge:
            return .get
        case .addApp:
            return .post
        case .deleteApp:
            return .delete
        case .postDailyChallenge:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .createChallenge(let data):
            return .requestJSONEncodable(data)
        case .dailyChallengeFail:
            return .requestPlain
        case .getChallenge:
            return .requestPlain
        case .getdailyChallenge:
            return .requestPlain
        case .addApp(let data):
            return .requestJSONEncodable(data)
        case .deleteApp(let data):
            return .requestJSONEncodable(data)
        case .postDailyChallenge(let data):
            return .requestJSONEncodable(data)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .createChallenge:
            return APIHeaders.hasTokenHeader
        case .dailyChallengeFail :
            return APIHeaders.hasTokenHeader
        case .getChallenge:
            return APIHeaders.hasTokenHeader
        case .getdailyChallenge:
            return APIHeaders.hasTokenHeader
        case .addApp:
            return APIHeaders.hasTokenHeader
        case .deleteApp:
            return APIHeaders.hasTokenHeader
        case .postDailyChallenge:
            return APIHeaders.hasTokenHeader
        }
    }
}

