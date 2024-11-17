//
//  RequestHandler_Refactor.swift
//  Networks
//
//  Created by 류희재 on 11/7/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

public struct RequestHandler {
    /// URLRequest 생성
    static public func createURLRequest<T: URLRequestTargetType>(for target: T) -> AnyPublisher<URLRequest, HMHNetworkError> {
        return target.asURLRequest()
            .mapError { ErrorHandler.handleRequestError(target, error: $0) }
            .eraseToAnyPublisher()
    }
    
    /// 인터셉터 적용
    static public func applyInterceptorIfNeeded(_ urlRequest: URLRequest, for target: URLRequestTargetType) -> AnyPublisher<URLRequest, HMHNetworkError> {
        if target.isWithInterceptor {
            return TokenInterceptor.shared.adapt(urlRequest)
        } else {
            return Just(urlRequest)
                .setFailureType(to: HMHNetworkError.self)
                .eraseToAnyPublisher()
        }
    }
}



