//
//  URLTargetTypeMockData.swift
//  NetworksTests
//
//  Created by 류희재 on 11/19/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Networks

public struct MockURLRequestTarget: URLRequestTargetType {
    public var url: String
    public var path: String?
    public var method: HTTPMethod
    public var headers: [String: String]?
    public var task: Task
    public var isWithInterceptor: Bool
    
    public init(
        url: String = "http://example.com",
        path: String? = "validPath",
        method: HTTPMethod = .get,
        headers: [String: String]? = ["Content-Type" : "application/json"],
        task: Task = .requestPlain,
        isWithInterceptor: Bool = false
    ) {
        self.url = url
        self.path = path
        self.method = method
        self.headers = headers
        self.task = task
        self.isWithInterceptor = isWithInterceptor
    }
}

extension MockURLRequestTarget {
    static var mockTargetType = MockURLRequestTarget.init()
}
