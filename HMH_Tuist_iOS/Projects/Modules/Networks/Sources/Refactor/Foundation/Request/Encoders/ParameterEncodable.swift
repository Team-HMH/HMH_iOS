//
//  ParameterEncoding.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

protocol ParameterEncodable {}

extension ParameterEncodable {
    func checkValidURLData(
        _ parameters: Parameters?,
        _ url: URL?
    ) -> AnyPublisher<(Parameters, URL), HMHNetworkError.ParameterEncoding> {
        guard let parameters else { return Fail(error: .emptyParameters).eraseToAnyPublisher() }
        guard let url else { return Fail(error: .missingURL).eraseToAnyPublisher() }
        
        return Just((parameters, url))
            .setFailureType(to: HMHNetworkError.ParameterEncoding.self)
            .eraseToAnyPublisher()
    }
    
    func checkValidURLData(
        _ parameters: Encodable?,
        _ url: URL?
    ) -> AnyPublisher<(Encodable, URL), HMHNetworkError.ParameterEncoding> {
        guard let parameters else { return Fail(error: .emptyParameters).eraseToAnyPublisher() }
        guard let url else { return Fail(error: .missingURL).eraseToAnyPublisher() }
        
        return Just((parameters, url))
            .setFailureType(to: HMHNetworkError.ParameterEncoding.self)
            .eraseToAnyPublisher()
    }
}
