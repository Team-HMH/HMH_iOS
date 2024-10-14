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
    case getUsagePoint
    case patchEarnPoint(data: PointRequestDTO)
    case getEarnPoint
    case getPointList
    case patchPointUse(data: PointRequestDTO)
}

extension PointAPI: BaseAPI {
    var path: String? {
        switch self {
        case .getUsagePoint:
            return Paths.getUsagePoint
        case .patchEarnPoint(data: let data):
            return Paths.patchEarnPoint
        case .getEarnPoint:
            return Paths.getEarnPoint
        case .getPointList:
            return Paths.getPointList
        case .patchPointUse:
            return Paths.patchPointUse
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsagePoint:
            return .get
        case .patchEarnPoint:
            return .patch
        case .getEarnPoint:
            return .get
        case .getPointList:
            return .get
        case .patchPointUse:
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case .getUsagePoint:
            return .requestPlain
        case .patchEarnPoint(data: let data):
            return .requestJSONEncodable(data)
        case .getEarnPoint:
            return .requestPlain
        case .getPointList:
            return .requestPlain
        case .patchPointUse(data: let data):
            return .requestJSONEncodable(data)
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
