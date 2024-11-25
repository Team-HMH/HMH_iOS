//
//  NetworkResponseMockData.swift
//  NetworksTests
//
//  Created by 류희재 on 11/19/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Networks

struct NetworkResponseMockData {
    static func responseWith(statusCode: Int, data: Data?) -> NetworkResponse {
        let httpResponse = HTTPURLResponse(
            url: URL(string: "https://api.example.com")!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
        return NetworkResponse(data: data, response: httpResponse, error: nil)
    }
    
    static let validErrorData = """
    {
        "status": 404,
        "message": "테스트를 위해서 사용된 에러메세지입니다!"
    }
    """.data(using: .utf8)
    
    
    static let invalidErrorData = """
    { "invalid": "data" }
    """.data(using: .utf8)
}
