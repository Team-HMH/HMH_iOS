//
//  URLValidationError.swift
//  Networks
//
//  Created by 류희재 on 11/12/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

extension HMHNetworkError {
    public enum URLValidationError: Error, Equatable {
        case emptyurlString
        case invalidProtocol
        case invalidPort
        case invalidPath
        case invalidQueryParameter
        
        var description: String {
            switch self {
            case .emptyurlString:
                return "주어진 url이 빈 문자열입니다"
            case .invalidProtocol:
                return "URL에서 사용하는 프로토콜이 http 또는 https가 아닙니다"
            case .invalidPort:
                return "URL에서 포트 번호가 잘못되었습니다"
            case .invalidPath:
                return "URL 경로가 잘못되었습니다"
            case .invalidQueryParameter:
                return "유효하지 않은 쿼리파라미터입니다.(쿼리 구분자/쿼리 파라미터 확인)"
            }
        }
    }
}
