//
//  RequestHandler.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

class RequestHandler {
    
    static let shared = RequestHandler()
    
    private init() {}
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        // TODO: Interceptor 추가
        return URLSession(configuration: configuration)
    }()
    
    func executeRequest<T: URLRequestTargetType>(for target: T, isWithInterceptor: Bool) -> AnyPublisher<NetworkResponse, HMHNetworkError> {
        return target.asURLRequest()
            .map { $0 }
            .mapError { ErrorHandler.handleError(target, error: .invalidRequest($0)) }
            .flatMap { urlRequest in
                if isWithInterceptor {
                    return TokenInterceptor
                        .catch { error in
                            // Adapt 실패 시 에러 처리
                            Just(urlRequest) // 원래 요청을 반환
                                .setFailureType(to: HMHNetworkError.RequestError.self)
                        }
                } else {
                    return Just(urlRequest)
                        .setFailureType(to: HMHNetworkError.RequestError.self)
                }
            }
            .flatMap { urlRequest in
                self.session.dataTaskPublisher(for: urlRequest)
                    .tryMap { data, response -> NetworkResponse in
                        guard let httpResponse = response as? HTTPURLResponse else {
                            throw HMHNetworkError.ResponseError.unhandled
                        }
                        return NetworkResponse(data: data, response: httpResponse, error: nil)
                    }
                    .mapError { error -> HMHNetworkError in
                        if let requestErr = error as? HMHNetworkError.ResponseError {
                            return .invalidResponse(requestErr)
                        } else {
                            return .unknown(error)
                        }
                    }
                    .eraseToAnyPublisher()
            }
        
            .eraseToAnyPublisher()
    }
}


