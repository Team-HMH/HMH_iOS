//
//  PointRouter.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/30/24.
//

import Foundation

import Moya
import Domain

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
            return APIHeaders.hasAccessTokenHeader
        case .patchEarnPoint :
            return APIHeaders.hasTokenHeader
        case .getEarnPoint:
            return APIHeaders.hasAccessTokenHeader
        case .getPointList:
            return APIHeaders.hasAccessTokenHeader
        case .patchPointUse:
            return APIHeaders.hasAccessTokenHeader
        case .getCurrentPoint:
            return APIHeaders.hasAccessTokenHeader
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
