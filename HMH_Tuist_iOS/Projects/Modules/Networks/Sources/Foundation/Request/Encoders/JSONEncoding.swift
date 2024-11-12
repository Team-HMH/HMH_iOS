//
//  JSONEncoding.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public struct JSONEncoding: ParameterEncoding {
    public init() {}
    
    public func encode(_ request: URLRequest, with parameters: Any?) -> AnyPublisher<URLRequest, HMHNetworkError.ParameterEncoding> {
        
        var request = request
        
        guard let encodable = parameters as? Encodable else {
            return Fail(error: .invalidJSON).eraseToAnyPublisher()
        }
        
        
        return RequestDataValidator.validateWithEncodable(encodable, request.url)
            .tryMap { parameters, _ -> URLRequest in
                do {
                    let data = try JSONEncoder().encode(parameters)
                    request.httpBody = data
                    return request
                } catch {
                    throw HMHNetworkError.invalidRequest(.parameterEncodingFailed(.jsonEncodingFailed))
                }
            }
            .mapError { $0 as! HMHNetworkError.ParameterEncoding } //TODO: 예외 상황이 없는거 같아서..
            .eraseToAnyPublisher()
    }
}
