//
//  RequestHandler.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

public class RequestHandler: RequestHandling {
    
    //    static let shared = RequestHandler()
    
    public init() {}
    
    private var retryCnt = 0
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        return URLSession(configuration: configuration)
    }()
    
    public func executeRequest<T: URLRequestTargetType>(for target: T) -> AnyPublisher<NetworkResponse, HMHNetworkError> {

        return target.asURLRequest()
            .map { $0 }
            .mapError { ErrorHandler.handleError(target, error: .invalidRequest($0)) }
            .flatMap { urlRequest in
                if target.isWithInterceptor {
                    return TokenInterceptor.shared.adapt(urlRequest)
                } else {
                    return Just(urlRequest)
                        .setFailureType(to: HMHNetworkError.self)
                        .eraseToAnyPublisher()
                }
            }
            .map { $0 }
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
    
    public func tokenRequest<T: URLRequestTargetType>(for target: T) -> AnyPublisher<NetworkResponse, HMHNetworkError> {
        retryCnt += 1
        return TokenInterceptor.shared.retry(for: session, retryCnt: retryCnt)
            .flatMap { tokenResult -> AnyPublisher<NetworkResponse, HMHNetworkError> in
                // 업데이트된 토큰을 UserManager에 저장
                UserManager.shared.accessToken = tokenResult.accessToken
                UserManager.shared.refreshToken = tokenResult.refreshToken
                
                // 토큰 갱신 후 요청을 다시 실행
                return self.executeRequest(for: target)
            }
            .catch { error -> AnyPublisher<NetworkResponse, HMHNetworkError> in
                // 토큰 갱신 실패 시 UserManager의 토큰 초기화
                UserManager.shared.accessToken = ""
                UserManager.shared.refreshToken = ""
                
                // 실패를 그대로 반환하여 스트림 종료
                return Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}


