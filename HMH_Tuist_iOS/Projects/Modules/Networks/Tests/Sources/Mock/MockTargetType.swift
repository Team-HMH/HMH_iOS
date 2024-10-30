//
//  MockTargetType.swift
//  Networks
//
//  Created by 류희재 on 10/30/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Networks

struct MockTarget: URLRequestTargetType {
    var url: String = "https://example.com"
    var path: String? = "/test"
    var method: HTTPMethod = .get
    var headers: [String : String]? = nil
    var task: Task = .requestPlain
    var isWithInterceptor: Bool = false

    func asURLRequest() -> AnyPublisher<URLRequest, HMHNetworkError.RequestError> {
        guard let url = URL(string: self.url) else {
            return Fail(error: .invalidURL(self.url)).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return Just(request).setFailureType(to: HMHNetworkError.RequestError.self).eraseToAnyPublisher()
    }
}

