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
        
        var description: String {
            switch self {
            case .cancelled:
                return "취소되었습니다."
            case .unhandled:
                return "응답이 올바르지 않습니다"
            case .invalidStatusCode(let code, let errMessage):
                switch code {
                case 401:
                    return "autheticationError: 인증오류입니다"
                case 403:
                    return errMessage ?? "forbiddeError: 금지된 에러입니다"
                case 404:
                    return errMessage ?? "notFoundError: 찾을 수 없습니다"
                case 408:
                    return "timeoutError: 시간을 초과했습니다"
                case 409:
                    return errMessage ?? "409 -> 해당 statuscode와 관련된 오류입니다"
                case 500:
                    return "internalServerError: 서버 내부 오류입니다"
                default:
                    return "\(code) -> 해당 statuscode와 관련된 오류입니다"
                }
            }
        }
        
        var statusCode: Int? {
            if case let .invalidStatusCode(code, _) = self {
                return code
            }
            return nil
        }
    }
}
