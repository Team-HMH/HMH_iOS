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
        var finalURL = self.url

        if let path = self.path {
            finalURL = finalURL.trimmingCharacters(in: .whitespacesAndNewlines) + "/" + path.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        switch URLValidator.validateURL(finalURL) {
        case .failure(let validationError):
            return Fail(error: .invalidURL(validationError)).eraseToAnyPublisher()
            
        case .success(let validURL):
            return task.buildRequest(baseURL: validURL, method: self.method, headers: self.headers)
        }
    }
}

