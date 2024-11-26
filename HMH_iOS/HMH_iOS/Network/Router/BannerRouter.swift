//
//  BannerRouter.swift
//  HMH_iOS
//
//  Created by 이지희 on 11/24/24.
//

import Foundation

import Moya

enum BannerRouter {
    case getBannerInfo
}

extension BannerRouter: BaseTargetType {
    var headers: [String : String]? {
        switch self {
        case .getBannerInfo:
            return APIConstants.hasAccessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .getBannerInfo:
            return "/v2/banner"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBannerInfo:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getBannerInfo:
            return .requestPlain
        }
    }
}
