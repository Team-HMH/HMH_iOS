//
//  PointRouter.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/30/24.
//

import Foundation

import Moya

enum PointRouter {
    case getUsagePoint
    case patchEarnPoint(data: PointRequestDTO)
    case getEarnPoint
    case getPointList
    case patchPointUse(data: PointRequestDTO)
    case getCurrentPoint
}

extension PointRouter: BaseTargetType {
    var headers: [String : String]? {
        switch self {
        case .getUsagePoint:
            return APIConstants.hasAccessTokenHeader
        case .patchEarnPoint :
            return APIConstants.hasTokenHeader
        case .getEarnPoint:
            return APIConstants.hasAccessTokenHeader
        case .getPointList:
            return APIConstants.hasAccessTokenHeader
        case .patchPointUse:
            return APIConstants.hasAccessTokenHeader
        case .getCurrentPoint:
            return APIConstants.hasAccessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .getUsagePoint:
            return "point/use"
        case .patchEarnPoint :
            return "point/earn"
        case .getEarnPoint :
            return "point/earn"
        case .getPointList:
            return "point/list"
        case .patchPointUse:
            return "point/use"
        case .getCurrentPoint:
            return "user/point"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUsagePoint:
            return .get
        case .patchEarnPoint :
            return .patch
        case .getEarnPoint :
            return .get
        case .getPointList:
            return .get
        case .patchPointUse:
            return .patch
        case .getCurrentPoint:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getUsagePoint:
            return .requestPlain
        case .patchEarnPoint(let data) :
            return .requestJSONEncodable(data)
        case .getEarnPoint:
            return .requestPlain
        case .patchPointUse(let data):
            return .requestJSONEncodable(data)
        case .getPointList:
            return .requestPlain
        case .getCurrentPoint:
            return .requestPlain
        }
    }
}
