//
//  BaseAPI.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

protocol BaseAPI: URLRequestTargetType { }

extension BaseAPI {
    public var url: String {
        return Config.baseURL
    }
    
    public var headers: [String: String]? {
        return APIHeaders.noTokenHeader
    }
}


