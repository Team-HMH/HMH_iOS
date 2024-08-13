//
//  APIError.swift
//  MyPageFeatureInterface
//
//  Created by 류희재 on 8/13/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public enum APIError: Error, Equatable {
    case network(statusCode: Int, response: ErrorResponse)
    case unknown
    case tokenReissuanceFailed
    
    init(error: Error, statusCode: Int? = 0, response: ErrorResponse) {
        guard let statusCode else { self = .unknown ; return }
        
        self = .network(statusCode: statusCode, response: response)
    }
}
