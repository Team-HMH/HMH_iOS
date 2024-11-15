//
//  URLEncodingMockData.swift
//  Networks
//
//  Created by 류희재 on 11/11/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct URLRequestMockData {
    static let mockURL = URL(string: "https://example.com")!

    static public let validRequestData: URLRequest = {
        var request = URLRequest(url: mockURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        return request
    }()
    
    static public let nilURLRequest: URLRequest = {
        var request = URLRequest(url: mockURL)
        request.url = nil
        request.httpMethod = "GET"
        return request
    }()

    static public let validURLNoParametersRequest: URLRequest = {
        var request = URLRequest(url: mockURL)
        request.httpMethod = "GET"
        return request
    }()
    
    static public let invalidURLRequest: URLRequest = {
        let url =  URL(string: "https://example.com/path?existingParam=123")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }()
}

