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
    static public func handleError<T: URLRequestTargetType>(_ target: T, error: HMHNetworkError) -> HMHNetworkError { NetworkLogHandler.responseError(target, result: error)
        return error
    }
    
    static public func handleRequestError<T: URLRequestTargetType>(_ target: T, error: HMHNetworkError.RequestError) -> HMHNetworkError {
        
        let requestError: HMHNetworkError = .invalidRequest(error)
        NetworkLogHandler.responseError(target, result: requestError)
        return requestError
    }
    
    static public func handleResponseError<T: URLRequestTargetType>(_ target: T, error: HMHNetworkError.ResponseError) -> HMHNetworkError {
        
        let responseError: HMHNetworkError = .invalidResponse(error)
        NetworkLogHandler.responseError(target, result: responseError)
        return responseError
    }
    
    static public func handleDecodingError<T: Decodable>(data:Data, decodingType: T.Type, error: HMHNetworkError.DecodeError) -> HMHNetworkError {
        
        let decodingError: HMHNetworkError = .decodingFailed(error)
        NetworkLogHandler.responseDecodingError(data: data, decodingType: T.self, error: error)
        return decodingError
    }
    
    
    // 유효하지 않은 응답인 경우 에러 처리
    static public func handleInvalidResponse(response: NetworkResponse) -> HMHNetworkError {
        if let data = response.data {
            do {
                // 에러 응답 모델로 디코딩 시도
                let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                return .invalidResponse(.invalidStatusCode(code: response.response.statusCode, message: errorResponse.message))
            } catch {
                return .invalidResponse(.invalidStatusCode(code: response.response.statusCode))
            }
        } else {
            return .invalidResponse(.invalidStatusCode(code: response.response.statusCode))
        }
    }
}

