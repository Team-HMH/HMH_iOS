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
    static private func validateURL(_ url: URL?) -> AnyPublisher<URL, HMHNetworkError.ParameterEncodingError> {
        guard let url else {
            return Fail(error: .missingURL).eraseToAnyPublisher()
        }
        return Just(url)
            .setFailureType(to: HMHNetworkError.ParameterEncodingError.self)
            .eraseToAnyPublisher()
    }
    
    static public func validateWithParameters(
        _ parameters: Parameters?,
        _ url: URL?
    ) -> AnyPublisher<(Parameters, URL), HMHNetworkError.ParameterEncodingError> {
        
        return validateURL(url)
            .flatMap { validatedURL -> AnyPublisher<(Parameters, URL), HMHNetworkError.ParameterEncodingError> in
                guard let parameters = parameters, !parameters.isEmpty else {
                    return Fail(error: .emptyParameters).eraseToAnyPublisher()
                }
                return Just((parameters, validatedURL))
                    .setFailureType(to: HMHNetworkError.ParameterEncodingError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    static public func validateWithEncodable(
        _ parameters: Encodable?,
        _ url: URL?
    ) -> AnyPublisher<(Encodable, URL), HMHNetworkError.ParameterEncodingError> {
        
        return validateURL(url)
            .flatMap { validatedURL -> AnyPublisher<(Encodable, URL), HMHNetworkError.ParameterEncodingError> in
                guard let parameters else {
                    return Fail(error: .emptyParameters).eraseToAnyPublisher()
                }
                return Just((parameters, validatedURL))
                    .setFailureType(to: HMHNetworkError.ParameterEncodingError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
