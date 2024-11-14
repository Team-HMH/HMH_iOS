//
//  HMHNetworkError.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

@frozen public enum HMHNetworkError: Error, Equatable {
    case invalidRequest(RequestError)
    case invalidResponse(ResponseError)
    case decodingFailed(DecodeError)
    case oautheticationError(AuthrizationError)
    case retryLimitExceeded
    case unknownError
    
    var description: String {
        switch self {
        case .invalidRequest(let requestError):
            return "요청 시 발생된" + requestError.description
        case .invalidResponse(let responseError):
            return "응답 시 발생된" + responseError.description
        case .decodingFailed(let decodeError):
            return decodeError.description
        case .oautheticationError(let authError):
            return authError.description
        case .retryLimitExceeded:
            return "네트워크 요청 횟수를 초과하였습니다!"
        case .unknownError:
            return "알 수 없는 오류가 발생하였습니다!"
        }
    }
}
