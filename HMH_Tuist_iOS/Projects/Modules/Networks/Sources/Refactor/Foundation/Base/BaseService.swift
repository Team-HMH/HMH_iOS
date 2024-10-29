//
//  BaseService.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

final class BaseService<Target: URLRequestTargetType> {
    
    typealias API = Target
    
    private let requestHandler = RequestHandler.shared
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        return URLSession(configuration: configuration)
    }()
    
    func requestWithResult<T: Decodable>(_ target: API) -> AnyPublisher<T, HMHNetworkError> {
        return fetchResponse(with: target)
            .flatMap { response in
                self.validate(response: response)
                    .map { _ in response.data! }
                    .mapError { ErrorHandler.handleError(target, error: $0) }
            }
            .flatMap { self.decode(data: $0, target: target) }
            .eraseToAnyPublisher()
    }
    
    func requestWithNoResult(_ target: API) -> AnyPublisher<Void, HMHNetworkError> {
        return fetchResponse(with: target)
            .flatMap { response -> AnyPublisher<Data, HMHNetworkError> in
                self.validate(response: response) // validate 연결
                    .map { _ in response.data! } // 성공 시 data 반환
                    .eraseToAnyPublisher()
            }
            .mapError { ErrorHandler.handleError(target, error: $0) }
            .flatMap { data -> AnyPublisher<VoidResult, HMHNetworkError> in
                self.decode(data: data, target: target)
            }
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}


extension BaseService {
    /// 네트워크 응답 처리 메소드
    private func fetchResponse(with target: API) -> AnyPublisher<NetworkResponse, HMHNetworkError> {
        return requestHandler.executeRequest(for: target, isWithInterceptor: target.isWithInterceptor)
            .handleEvents(receiveSubscription:  {  _ in
                NetworkLogHandler.requestLogging(target)
            }, receiveOutput:  {  response in
                NetworkLogHandler.responseSuccess(target, result: response)
            })
            .mapError { ErrorHandler.handleError(target, error: $0) }
            .eraseToAnyPublisher()
    }
    
    /// 응답 유효성 검사 메서드
    private func validate(response: NetworkResponse) -> AnyPublisher<Void, HMHNetworkError> {
        guard response.response.isValidateStatus() else {
            if response.response.unAuthorized() {
                RequestHandler.shared.tokenRequest()
            }
            let error = ErrorHandler.handleInvalidResponse(response: response)
            return Fail(error: error).eraseToAnyPublisher()
        }

        return Just(()).setFailureType(to: HMHNetworkError.self).eraseToAnyPublisher()
    }

    
    /// 디코딩 메소드
    private func decode<T: Decodable>(data: Data, target: API) -> AnyPublisher<T, HMHNetworkError> {
        return Just(data)
            .decode(type: GenericResponse<T>.self, decoder: JSONDecoder())
            .mapError { _ in ErrorHandler.handleError(target, error: .decodingFailed(.failed)) }
            .map { $0.data! }
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

