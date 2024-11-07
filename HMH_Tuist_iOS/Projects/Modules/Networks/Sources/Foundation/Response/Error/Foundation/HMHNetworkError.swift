//
//  HMHNetworkError.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

@frozen public enum HMHNetworkError: Error {
    case invalidRequest(RequestError)
    case invalidResponse(ResponseError)
    case decodingFailed(DecodeError)
    case oautheticationError(AuthrizationError)
    case timeOutError
    case unknown(Error)
    
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
        case .timeOutError:
            return "시간 초과되었습니다!"
        case .unknown(let error):
            return "알 수 없는 오류 \(error)가 발생하였습니다!"
        }
    }
}
