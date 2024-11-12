//
//  Task.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public enum Task {
    case requestPlain
    case requestParameters(Parameters)
    case requestJSONEncodable(Encodable)
}

extension Task {
    public func buildRequest(baseURL: URL, method: HTTPMethod, headers: [String: String]?) -> AnyPublisher<URLRequest, HMHNetworkError.RequestError> {
        var request = URLRequest(url: baseURL)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        switch self {
        case .requestPlain:
            return Just(request)
                .setFailureType(to: HMHNetworkError.RequestError.self)
                .eraseToAnyPublisher()
                
        case .requestParameters(let parameters):
            return URLEncoding().encode(request, with: parameters)
                .mapError { .parameterEncodingFailed($0) }
                .eraseToAnyPublisher()
                
        case .requestJSONEncodable(let encodable):
            return JSONEncoding().encode(request, with: encodable)
                .mapError { .parameterEncodingFailed($0) }
                .eraseToAnyPublisher()
        }
    }
}
