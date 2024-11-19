//
//  ErrorHandler.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public struct ErrorHandler {
    static public func handleDecodingError<T: Decodable>(data:Data, decodingType: T.Type, error: HMHNetworkError.DecodeError) -> HMHNetworkError {
        
        let decodingError: HMHNetworkError = .decodingFailed(error)
        NetworkLogHandler.responseDecodingError(data: data, decodingType: T.self, error: error)
        return decodingError
    }
    
    static public func handleRetryLimitExceeded() -> HMHNetworkError {
        let error: HMHNetworkError = .retryLimitExceeded
        NetworkLogHandler.tokenIntercepterRetryError(error: error)
        return error
    }
}

extension ErrorHandler {
    static public func handleRequestError(_ error: HMHNetworkError.RequestError) -> HMHNetworkError {
        let requestError: HMHNetworkError = .invalidRequest(error)
        return requestError
    }
    
    static public func handleParameterEncodingError(
        _ request: URLRequest,
        _ parameter: Any? = nil,
        error: HMHNetworkError.RequestError.ParameterEncodingError
    ) -> HMHNetworkError.RequestError {
        
        NetworkLogHandler.requestParameterEncodingError(request, parameter, error: error)
        return .parameterEncodingFailed(error)
    }
    
    static public func handleInvalidURLError<T: URLRequestTargetType>(
        _ target: T,
        error: HMHNetworkError.RequestError.URLValidationError
    ) -> AnyPublisher<URLRequest, HMHNetworkError.RequestError> {
        
        NetworkLogHandler.requestInvalidURLError(target, result: error)
        return Fail(error: .invalidURL(error)).eraseToAnyPublisher()
    }
}

extension ErrorHandler {
    static public func handleNoResponseError<T: URLRequestTargetType>(_ target: T, error: HMHNetworkError.ResponseError) -> HMHNetworkError {
        
        NetworkLogHandler.NoResponseError(target, error: error)
        return .invalidResponse(error)
    }
    
    static public func handleInvalidResponse(response: NetworkResponse) -> HMHNetworkError {
        let error: HMHNetworkError.ResponseError
        if let data = response.data {
            if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                error = .invalidStatusCode(code: response.response.statusCode, message: errorResponse.message)
            } else {
                error = .invalidStatusCode(code: response.response.statusCode)
            }
        } else {
            error = .noResponseData
        }
        
        NetworkLogHandler.invalidReponseError(response: response, error: error)
        return .invalidResponse(error)
    }
}
