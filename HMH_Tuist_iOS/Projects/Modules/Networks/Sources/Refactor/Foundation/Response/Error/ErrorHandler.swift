//
//  ErrorHandler.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

struct ErrorHandler {
    static func handleError<T: URLRequestTargetType>(_ target: T, error: HMHNetworkError) -> HMHNetworkError { NetworkLogHandler.responseError(target, result: error)
        return error
    }
    
    // 유효하지 않은 응답인 경우 에러 처리
    static func handleInvalidResponse(response: NetworkResponse) -> HMHNetworkError {
        if let data = response.data {
            do {
                // 에러 응답 모델로 디코딩 시도
                let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                return .invalidResponse(.invalidStatusCode(code: response.response.statusCode, data: errorResponse.data))
            } catch {
                return .invalidResponse(.invalidStatusCode(code: response.response.statusCode))
            }
        } else {
            return .invalidResponse(.invalidStatusCode(code: response.response.statusCode))
        }
    }
}

