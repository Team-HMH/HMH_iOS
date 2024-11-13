//
//  MockEncodingData.swift
//  Networks
//
//  Created by 류희재 on 11/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Foundation
import Combine

public struct MockParameterEncoding: ParameterEncoding {
    private let error: HMHNetworkError.ParameterEncodingError

    public init(error: HMHNetworkError.ParameterEncodingError) {
        self.error = error
    }

    public func encode(_ request: URLRequest, with parameters: Any?) -> AnyPublisher<URLRequest, HMHNetworkError.ParameterEncodingError> {
        return Fail(error: self.error)
            .eraseToAnyPublisher()
    }
}
