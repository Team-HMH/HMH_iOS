//
//  RequestError.swift
//  Networks
//
//  Created by 류희재 on 10/31/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

extension HMHNetworkError {
    public enum RequestError: Error, Equatable {
        case parameterEncodingFailed(ParameterEncodingError) // 인코딩시 생기는 에러
        case invalidURL(String, URLValidationError) // url이 유효하지 않을때
        case unknownErr // 그 외 예기치 못한 에러
        
        var description: String {
            switch self {
            case .parameterEncodingFailed(let parameterEncodingError):
                return "인코딩 시 발생한" + parameterEncodingError.description
            case .invalidURL(let url, let urlValidationError):
                return "\(url)은 \(urlValidationError.description)"
            case .unknownErr:
                return "요청 시 발생한 알 수 없는 에러입니다."
            }
        }
    }
}

