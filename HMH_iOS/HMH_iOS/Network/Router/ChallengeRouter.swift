//
//  ChallengeRouter.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/12/24.
//

import Foundation

import Moya

enum ChallengeRouter {
    case createChallenge(data: CreateChallengeRequestDTO)
    case dailyChallengeFail
    case getChallenge
    case getdailyChallenge
    case addApp(data: AddAppRequestDTO)
    case deleteApp(data: DeleteAppRequestDTO)
    case patchdailyChallenge(data: MidnightRequestDTO)
    case getDummyData
}

extension ChallengeRouter: BaseTargetType {
    var headers: [String : String]? {
        switch self {
        case .createChallenge:
            return APIConstants.hasTokenHeader
        case .dailyChallengeFail :
            return APIConstants.hasTokenHeader
        case .getChallenge:
            return APIConstants.hasTokenHeader
        case .getdailyChallenge:
            return APIConstants.hasTokenHeader
        case .addApp:
            return APIConstants.hasTokenHeader
        case .deleteApp:
            return APIConstants.hasTokenHeader
        case .patchdailyChallenge:
            return APIConstants.hasTokenHeader
        case .getDummyData:
            return APIConstants.hasTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .createChallenge:
            return "challenge"
        case .dailyChallengeFail:
            return "dailychallenge/failure"
        case .getChallenge:
            return "challenge"
        case .getdailyChallenge:
            return "dailychallenge"
        case .addApp:
            return "app"
        case .deleteApp:
            return "app"
        case .patchdailyChallenge:
            return "dailychallenge"
        case .getDummyData:
            return "dummy/app"
        }
    }
    
    var method: Moya.Method {
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
        case .patchdailyChallenge:
            return .patch
        case .getDummyData:
            return .get
        }
    }
    
    var task: Moya.Task {
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
        case .patchdailyChallenge(let data):
            return .requestJSONEncodable(data)
        case .getDummyData:
            return .requestPlain
        }
    }
}
