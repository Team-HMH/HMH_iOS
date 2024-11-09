//
//  BaseService_Refactor.swift
//  Networks
//
//  Created by 류희재 on 11/7/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine
import Core

public final class BaseService<Target: URLRequestTargetType> {
    
    public init() {}
    
    public typealias API = Target
    
    private var retryCnt = 0
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        return URLSession(configuration: configuration)
    }()
    
    
    func requestWithResult<T: Decodable>(_ target: API) -> AnyPublisher<T, HMHNetworkError> {
        return fetchResponse(with: target)
            .flatMap { response in
                self.validate(response: response, target: target)
                    .map { _ in response.data! }
                    .mapError { ErrorHandler.handleError(target, error: $0) }
            }
            .flatMap { data in
                self.decode(data: data)
                    .mapError { ErrorHandler.handleDecodingError(data: data, decodingType: T.self, error: $0) }
            }
            .eraseToAnyPublisher()
    }
    
    func requestWithNoResult(_ target: API) -> AnyPublisher<Void, HMHNetworkError> {
        return fetchResponse(with: target)
            .flatMap { response in
                self.validate(response: response, target: target)
                    .map { _ in response.data! }
                    .mapError { ErrorHandler.handleError(target, error: $0) }
            }
            .flatMap { data -> AnyPublisher<VoidResult, HMHNetworkError> in
                self.decode(data: data)
                    .mapError { ErrorHandler.handleDecodingError(data: data, decodingType: VoidResult.self, error: $0) }
                    .eraseToAnyPublisher()
            }
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
extension BaseService {
    
    // dataTask 네트워크 요청 수행
    private func performDataTask(with urlRequest: URLRequest) -> AnyPublisher<NetworkResponse, HMHNetworkError.ResponseError> {
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw HMHNetworkError.ResponseError.unhandled
                }
                return NetworkResponse(data: data, response: httpResponse, error: nil)
            }
            .mapError { ($0 as? HMHNetworkError.ResponseError) ?? .unknown }
            .eraseToAnyPublisher()
    }
    
    
    /// 네트워크 응답 처리 메소드
    private func fetchResponse(with target: API) -> AnyPublisher<NetworkResponse, HMHNetworkError> {
        return RequestHandler.createURLRequest(for: target)
            .map { $0 }
            .flatMap { urlRequest in
                self.performDataTask(with: urlRequest)
                    .mapError { error in ErrorHandler.handleResponseError(target, error: error)}
            }
            .handleEvents(receiveSubscription:  {  _ in
                NetworkLogHandler.requestLogging(target)
            }, receiveOutput:  {  response in
                NetworkLogHandler.responseSuccess(target, result: response)
            })
            .eraseToAnyPublisher()
    }
    
    
    /// 응답 유효성 검사 메서드
    private func validate(response: NetworkResponse, target: API) -> AnyPublisher<Void, HMHNetworkError> {
        guard response.response.isValidateStatus() else {
            // 401 인증 오류 발생 시 토큰 갱신 후 재요청
            if response.response.unAuthorized() {
                return refreshTokenAndRetry(for: target)
                
            }
            // 기타 오류 발생 시 에러 반환
            let error = ErrorHandler.handleInvalidResponse(response: response)
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return Just(())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    /// 디코딩 메소드
    private func decode<T: Decodable>(data: Data) -> AnyPublisher<T, HMHNetworkError.DecodeError> {
        return Just(data)
            .decode(type: GenericResponse<T>.self, decoder: JSONDecoder())
            .mapError { _ in .failed }
            .map { $0.data! }
            .eraseToAnyPublisher()
    }
    
    private func refreshTokenAndRetry(for target: API) -> AnyPublisher<Void, HMHNetworkError> {
        retryCnt += 1
        return TokenInterceptor.shared.retry(for: session, retryCnt: retryCnt)
            .flatMap { tokenResult -> AnyPublisher<Void, HMHNetworkError> in
                UserManager.shared.accessToken = tokenResult.accessToken
                UserManager.shared.refreshToken = tokenResult.refreshToken
                return self.fetchResponse(with: target)
                    .flatMap { newResponse in
                        self.validate(response: newResponse, target: target)
                    }
                    .eraseToAnyPublisher()
            }
            .catch { error -> AnyPublisher<Void, HMHNetworkError> in
                UserManager.shared.accessToken = ""
                UserManager.shared.refreshToken = ""
                return Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

}

// HTTP 상태코드 유효성 검사
extension HTTPURLResponse {
    func isValidateStatus() -> Bool {
        return (200...299).contains(self.statusCode)
    }

    func unAuthorized() -> Bool {
        return self.statusCode == 401
    }
}


