//
//  JSONEncoding.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol JSONEncodingType {
    func encode(_ request: URLRequest, with parameters: Encodable) -> AnyPublisher<URLRequest, HMHNetworkError.RequestError.ParameterEncodingError>
}

public struct JSONEncoding: JSONEncodingType {
    public init() {}
    
    public func encode(_ request: URLRequest, with parameters: Encodable) -> AnyPublisher<URLRequest, HMHNetworkError.RequestError.ParameterEncodingError> {
        
        return Just(request)
            .tryMap { request in
                var modifiedRequest = request
                
                do {
                    let data = try JSONEncoder().encode(parameters)
                    modifiedRequest.httpBody = data
                    return modifiedRequest
                } catch {
                    throw HMHNetworkError.RequestError.ParameterEncodingError.jsonEncodingFailed
                }
            }
            .mapError { _ in HMHNetworkError.RequestError.ParameterEncodingError.unknownErr }
            .eraseToAnyPublisher()
    }
}
