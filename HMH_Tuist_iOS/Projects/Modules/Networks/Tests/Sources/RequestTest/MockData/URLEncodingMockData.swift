//
//  URLEncodingMockData.swift
//  Networks
//
//  Created by 류희재 on 11/11/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct URLEncodingMockData {
    static let mockURL = URL(string: "https://example.com")!

    // 1. Valid URLRequest with valid parameters
    static public let validRequestData: URLRequest = {
        var request = URLRequest(url: mockURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        return request
    }()
    
    // 2. URLRequest with nil URL
    static public let nilURLRequest: URLRequest = {
        var request = URLRequest(url: mockURL)
        request.url = nil
        request.httpMethod = "GET"
        return request
    }()

    // 10. URLRequest with valid URL but no parameters
    static public let validURLNoParametersRequest: URLRequest = {
        var request = URLRequest(url: mockURL)
        request.httpMethod = "GET"
        return request
    }()
}

