//
//  ParameterEncoding.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//


//TODO: 필요없어진 파일 but 혹시 모르니까
//import Foundation
//import Combine
//
//public struct RequestDataValidator {
//    static public func validateWithParameters(
//        _ parameters: Parameters?,
//        _ url: URL
//    ) -> AnyPublisher<(Parameters, URL), HMHNetworkError.ParameterEncodingError> {
//        
//        guard let parameters = parameters, !parameters.isEmpty else {
//            return Fail(error: .emptyParameters).eraseToAnyPublisher()
//        }
//        
//        return Just((parameters, url))
//            .setFailureType(to: HMHNetworkError.ParameterEncodingError.self)
//            .eraseToAnyPublisher()
//    }
//    
//    
//    static public func validateWithEncodable(
//        _ parameters: Encodable,
//        _ url: URL
//    ) -> AnyPublisher<(Encodable, URL), HMHNetworkError.ParameterEncodingError> {
//        return Just((parameters, url))
//            .setFailureType(to: HMHNetworkError.ParameterEncodingError.self)
//            .eraseToAnyPublisher()
//    }
//}
