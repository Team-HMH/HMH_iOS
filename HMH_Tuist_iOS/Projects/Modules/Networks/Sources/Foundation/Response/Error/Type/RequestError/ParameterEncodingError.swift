//
//  ParameterEncodingError.swift
//  Networks
//
//  Created by 류희재 on 11/12/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
extension HMHNetworkError {
    public enum ParameterEncodingError: Error, Equatable {
        case emptyParameters // 파라미터가 비어있을 때
        case missingURL // url이 없을때
        case invalidJSON // json 형식에 맞지 않을때
        case invalidParametersType // Parameters 형식에 맞지 않을때
        case jsonEncodingFailed // json으로 인코딩 할 시
        case unknownErr // 그 외 예기치 못한 에러
        
        var description: String {
            switch self {
            case .emptyParameters:
                return "파라미터가 비어있는 에러입니다."
            case .missingURL:
                return "url이 없습니다"
            case .invalidJSON:
                return "json 형식에 맞지 않습니다."
            case .invalidParametersType:
                return "Parameters 형식에 맞지 않습니다"
            case .jsonEncodingFailed:
                return "json 인코딩 시 발생한 에러입니다."
            case .unknownErr:
                return "파라미터 인코딩 시 알 수 없는 에러입니다"
            }
        }
    }
}

