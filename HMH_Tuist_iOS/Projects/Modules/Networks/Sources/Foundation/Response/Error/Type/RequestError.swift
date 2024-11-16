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
        case invalidURL(URLValidationError) // url이 유효하지 않을때
        case unknownErr // 그 외 예기치 못한 에러
        
        var description: String {
            switch self {
            case .parameterEncodingFailed(let parameterEncodingError):
                return "인코딩 시 발생한" + parameterEncodingError.description
            case .invalidURL(let urlValidationError):
                return urlValidationError.description
            case .unknownErr:
                return "요청 시 발생한 알 수 없는 에러입니다."
            }
        }
        
        public enum ParameterEncodingError: Error, Equatable {
            case emptyParameters // 파라미터가 비어있을 때
            case missingURL // url이 없을때
            case urlEncodingFailed // url로 인코딩 실패시
            case jsonEncodingFailed // json으로 인코딩 실패시
            case unknownErr // 그 외 예기치 못한 에러
            
            var description: String {
                switch self {
                case .emptyParameters:
                    return "파라미터가 비어있는 에러입니다."
                case .missingURL:
                    return "url이 없습니다"
                case .urlEncodingFailed:
                    return "url 인코딩 시 발생한 에러입니다."
                case .jsonEncodingFailed:
                    return "json 인코딩 시 발생한 에러입니다."
                case .unknownErr:
                    return "파라미터 인코딩 시 알 수 없는 에러입니다"
                }
            }
        }
        
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
}

