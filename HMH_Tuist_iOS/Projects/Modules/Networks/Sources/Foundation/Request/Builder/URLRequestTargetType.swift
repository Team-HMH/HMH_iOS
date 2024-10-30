//
//  URLRequestTargetType.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol URLRequestTargetType {
    var url: String { get }
    var path: String? { get }
    var method: HTTPMethod { get }
    var headers : [String : String]? { get }
    var task: Task { get }
    var isWithInterceptor: Bool { get }
    
    func asURLRequest() -> AnyPublisher<URLRequest, HMHNetworkError.RequestError>
}

extension URLRequestTargetType {
    public func asURLRequest() -> AnyPublisher<URLRequest, HMHNetworkError.RequestError> {
        guard let url = URL(string: self.url) else {
            return Fail(error: .invalidURL(self.url)).eraseToAnyPublisher()
        }

        var baseURL = url
        if let path = self.path { baseURL.appendPathComponent(path) }

        return task.buildRequest(baseURL: baseURL, method: self.method, headers: self.headers)
    }
}

