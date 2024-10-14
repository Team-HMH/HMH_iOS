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
    case unknown(Error)
    
    var description: String {
        switch self {
        case .invalidRequest(let requestError):
            return "요청 시 발생된" + requestError.description
        case .invalidResponse(let responseError):
            return "응답 시 발생된" + responseError.description
        case .decodingFailed(let decodeError):
            return decodeError.description
        case .unknown(let error):
            return "알 수 없는 오류 \(error)가 발생하였습니다!"
        }
    }
}

extension HMHNetworkError {
    public enum RequestError: Error {
        case parameterEncodingFailed(ParameterEncoding) // 인코딩시 생기는 에러
        case invalidURL(String) // url이 유효하지 않을때
        case unknownErr // 그 외 예기치 못한 에러
        
        var description: String {
            switch self {
            case .parameterEncodingFailed(let parameterEncoding):
                return "인코딩 시 발생한" + parameterEncoding.description
            case .invalidURL(let string):
                return "\(string)은 유효한 url이 아닙니다"
            case .unknownErr:
                return "요청 시 발생한 알 수 없는 에러입니다."
            }
        }
    }
    
    public enum ParameterEncoding: Error {
        case emptyParameters // 파라미터가 비어있을 때
        case missingURL // url이 없을때
        case invalidJSON // json 형식에 맞지 않을때
        case jsonEncodingFailed // json으로 인코딩 할 시
        
        var description: String {
            switch self {
            case .emptyParameters:
                return "파라미터가 비어있는 에러입니다."
            case .missingURL:
                return "url이 없습니다"
            case .invalidJSON:
                return "json 형식에 맞지 않습니다."
            case .jsonEncodingFailed:
                return "json 인코딩 시 발생한 에러입니다."
            }
        }
    }
}

extension HMHNetworkError {
    public enum ResponseError: Error {
        case cancelled
        case unhandled
        case invalidStatusCode(code: Int, data: String? = nil)
        
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

extension HMHNetworkError {
    public enum DecodeError: Error {
        case failed
        case dataIsNil
        
        var description: String {
            switch self {
            case .failed:
                return "디코딩에 실패했습니다"
            case .dataIsNil:
                return "데이터가 존재하지 않습니다."
            }
        }
    }
}

