//
//  PointAPI.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Domain

enum PointAPI {
    case patchPointUse
    case getEarnPoint
    case getUsagePoint
    case getPointList
    case patchEarnPoint(request: UserPointRequest)
}

extension PointAPI: BaseAPI {
    var isWithInterceptor: Bool {
        return false
    }
    
    var path: String? {
        switch self {
        case .patchPointUse:
            return Paths.patchPointUse
        case .getEarnPoint:
            return Paths.getEarnPoint
        case .getUsagePoint:
            return Paths.getUsagePoint
        case .getPointList:
            return Paths.getPointList
        case .patchEarnPoint:
            return Paths.patchEarnPoint
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .patchPointUse:
            return .patch
        case .getEarnPoint:
            return .get
        case .getUsagePoint:
            return .get
        case .getPointList:
            return .get
        case .patchEarnPoint:
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case .patchPointUse:
            return .requestPlain
        case .getEarnPoint:
            return .requestPlain
        case .getUsagePoint:
            return .requestPlain
        case .getPointList:
            return .requestPlain
        case .patchEarnPoint(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getEarnPoint:
            return APIHeaders.hasTokenHeader
        default:
            return APIHeaders.hasAccessTokenHeader
        }
    }
}
