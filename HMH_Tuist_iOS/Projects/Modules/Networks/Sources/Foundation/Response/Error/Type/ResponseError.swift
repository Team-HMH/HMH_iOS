//
//  ResponseError.swift
//  Networks
//
//  Created by 류희재 on 10/31/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

extension HMHNetworkError {
    public enum ResponseError: Error {
        case cancelled
        case unhandled
        case invalidStatusCode(code: Int, message: String? = nil)
        case unknown
        
        var description: String {
            switch self {
            case .cancelled:
                return "취소되었습니다."
            case .unhandled:
                return "응답이 올바르지 않습니다"
            case .invalidStatusCode(let code, let errMessage):
                return "\(StatusCodeError.from(code).description)/n\(errMessage ?? "추가적인 에러 메세지는 없습니다")"
            case .unknown:
                return "알 수 없는 응답에러입니다"
            }
        }
    }
}

extension HMHNetworkError.ResponseError {
    public func invalidStatusCodeMessage() -> String? {
        if case let .invalidStatusCode(_, message) = self {
            return message
        }
        return nil
    }
}

enum StatusCodeError: Int {
    case invalidRequestError = 400
    case authenticationError = 401
    case forbiddenError = 403
    case notFoundError = 404
    case notAllowedHTTPMethodError = 405
    case timeoutError = 408
    case internalServerError = 500
    case notSupportedError = 501
    case badGatewayError = 502
    case invalidServiceError = 503
    case unknownError
    
    var description: String {
        switch self {
        case .invalidRequestError: return "400:INVALID_REQUEST_ERROR"
        case .authenticationError: return "401:AUTHENTICATION_FAILURE_ERROR"
        case .forbiddenError: return "403:FORBIDDEN_ERROR"
        case .notFoundError: return "404:NOT_FOUND_ERROR"
        case .notAllowedHTTPMethodError: return "405:NOT_ALLOWED_HTTP_METHOD_ERROR"
        case .timeoutError: return "408:TIMEOUT_ERROR"
        case .internalServerError: return "500:INTERNAL_SERVER_ERROR"
        case .notSupportedError: return "501:NOT_SUPPORTED_ERROR"
        case .badGatewayError: return "502:BAD_GATEWAY_ERROR"
        case .invalidServiceError: return "503:INVALID_SERVICE_ERROR"
        case .unknownError: return "UNKNOWN_ERROR"
        }
    }
    
    static func from(_ code: Int) -> StatusCodeError {
        return StatusCodeError(rawValue: code) ?? .unknownError
    }
}
