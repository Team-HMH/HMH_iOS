//
//  MockNetworkError.swift
//  Data
//
//  Created by 류희재 on 11/5/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Networks

extension HMHNetworkError {
    static public var mockNetworkError: [HMHNetworkError] {
        return [
//            .invalidRequest(.invalidURL("Bad URL", <#HMHNetworkError.URLValidationError#>)),
            .invalidRequest(.parameterEncodingFailed(.emptyParameters)),
//            .invalidRequest(.parameterEncodingFailed(.invalidJSON)),
            .invalidRequest(.parameterEncodingFailed(.jsonEncodingFailed)),
            .invalidRequest(.parameterEncodingFailed(.missingURL)),
            .invalidRequest(.unknownErr),
            .decodingFailed(.dataIsNil),
            .decodingFailed(.decodingFailed)
        ]
    }
}
