//
//  ParameterEncoding.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public struct RequestDataValidator {
    static public func validateWithParameters(
        _ parameters: Parameters?,
        _ url: URL?
    ) -> AnyPublisher<(Parameters, URL), HMHNetworkError.ParameterEncoding> {
        guard let url else { return Fail(error: .missingURL).eraseToAnyPublisher() }
        
        guard let parameters = parameters, !parameters.isEmpty else {
                return Fail(error: .emptyParameters).eraseToAnyPublisher()
            }
        
        return Just((parameters, url))
            .setFailureType(to: HMHNetworkError.ParameterEncoding.self)
            .eraseToAnyPublisher()
    }
    
    static public func validateWithEncodable(
        _ parameters: Encodable?,
        _ url: URL?
    ) -> AnyPublisher<(Encodable, URL), HMHNetworkError.ParameterEncoding> {
        guard let url else { return Fail(error: .missingURL).eraseToAnyPublisher() }
        
        guard let parameters else { return Fail(error: .emptyParameters).eraseToAnyPublisher() }
        
        
        return Just((parameters, url))
            .setFailureType(to: HMHNetworkError.ParameterEncoding.self)
            .eraseToAnyPublisher()
    }
}
