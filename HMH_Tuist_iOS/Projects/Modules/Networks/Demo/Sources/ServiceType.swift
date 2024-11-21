//
//  ServiceType.swift
//  NetworksDemo
//
//  Created by 류희재 on 11/22/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Networks

enum ServiceType {
    case auth
    case point
    case challenge
    case user
    
    var apiList: [String] {
        switch self {
        case .auth:
            return [
                "SignUp",
                "SocialLogin"
            ]
        case .point:
            return [
                "PatchPointUse",
                "GetEarnPoint",
                "GetUsagePoint",
                "GetPointList",
                "PatchEarnPoint"
            ]
        case .challenge:
            <#code#>
        case .user:
            <#code#>
        }
    }
}
