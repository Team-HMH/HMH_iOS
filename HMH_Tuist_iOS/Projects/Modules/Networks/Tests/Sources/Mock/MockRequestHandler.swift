////
////  MockRequestHandler.swift
////  Networks
////
////  Created by 류희재 on 10/30/24.
////  Copyright © 2024 HMH-iOS. All rights reserved.
////
//
//import Combine
//import Foundation
//
//import Networks
//
//import Foundation
//import Combine
//
//public class MockRequestHandler: RequestHandling {
//    public func executeRequest<T>(for target: T) -> AnyPublisher<Networks.NetworkResponse, Networks.HMHNetworkError> where T : Networks.URLRequestTargetType {
//        <#code#>
//    }
//    
//    public func tokenRequest<T>(for target: T) -> AnyPublisher<Networks.NetworkResponse, Networks.HMHNetworkError> where T : Networks.URLRequestTargetType {
//        <#code#>
//    }
//    
//    
//    private lazy var session: URLSession = {
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = 10
//        configuration.timeoutIntervalForResource = 10
//        // TODO: Interceptor 추가
//        return URLSession(configuration: configuration)
//    }()
//    
//    public func executeRequest<T: URLRequestTargetType>(for target: T, isWithInterceptor: Bool) -> AnyPublisher<NetworkResponse, HMHNetworkError> {
//        return target.asURLRequest()
//            .map { $0 }
//            .mapError { ErrorHandler.handleError(target, error: .invalidRequest($0)) }
////            .flatMap { urlRequest in
////                if isWithInterceptor {
//////                    return TokenInterceptor.shared.adapt(urlRequest)
////                } else {
////                    return Just(urlRequest)
////                        .setFailureType(to: HMHNetworkError.self)
////                        .eraseToAnyPublisher()
////                }
////            }
////            .map { $0 }
//            .flatMap { urlRequest in
//                self.session.dataTaskPublisher(for: urlRequest)
//                    .tryMap { data, response -> NetworkResponse in
//                        guard let httpResponse = response as? HTTPURLResponse else {
//                            throw HMHNetworkError.ResponseError.unhandled
//                        }
//                        return NetworkResponse(data: data, response: httpResponse, error: nil)
//                    }
//                    .mapError { error -> HMHNetworkError in
//                        if let requestErr = error as? HMHNetworkError.ResponseError {
//                            return .invalidResponse(requestErr)
//                        } else {
//                            return .unknown(error)
//                        }
//                    }
//                    .eraseToAnyPublisher()
//            }
//            .eraseToAnyPublisher()
//    }
//    
//    public func tokenRequest() {
////        TokenInterceptor.shared.retry(for: session)
//    }
//}
//
//
