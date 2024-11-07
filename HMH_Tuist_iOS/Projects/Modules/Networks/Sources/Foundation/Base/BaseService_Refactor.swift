//
//  BaseService_Refactor.swift
//  Networks
//
//  Created by 류희재 on 11/7/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public final class BaseService_Refactor<Target: URLRequestTargetType> {
    
    public typealias API = Target
    
    private let requestHandler = RequestHandler_Refactor.shared
    
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
            .flatMap {
                self.decode(data: $0)
                    .mapError { ErrorHandler.handleDecodingError(error: $0) }
            }
            .eraseToAnyPublisher()
    }
    
    func requestWithNoResult(_ target: API) -> AnyPublisher<Void, HMHNetworkError> {
        return fetchResponse(with: target)
            .flatMap { response in
                self.validate(response: response, target: target) // validate 연결
                    .map { _ in response.data! } // 성공 시 data 반환
                    .mapError { ErrorHandler.handleError(target, error: $0) }
            }
            .flatMap { data -> AnyPublisher<VoidResult, HMHNetworkError> in
                self.decode(data: data)
                    .mapError { ErrorHandler.handleDecodingError(error: $0) }
                    .eraseToAnyPublisher()
            }
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
extension BaseService_Refactor {
    // dataTask 네트워크 요청 수행
    private func performDataTask(with urlRequest: URLRequest) -> AnyPublisher<NetworkResponse, HMHNetworkError.ResponseError> {
        return self.session.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> NetworkResponse in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw HMHNetworkError.ResponseError.unhandled
                }
                return NetworkResponse(data: data, response: httpResponse, error: nil)
            }
            .mapError { error -> HMHNetworkError.ResponseError in
                if let requestErr = error as? HMHNetworkError.ResponseError {
                    return requestErr
                } else {
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }

    
    /// 네트워크 응답 처리 메소드
    private func fetchResponse(with target: API) -> AnyPublisher<NetworkResponse, HMHNetworkError> {
        return requestHandler.createURLRequest(for: target)
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
//                return requestHandler.tokenRequest(for: target)
//                    .flatMap { _ in
//                        self.validate(response: response, target: target)
//                    }
//                    .eraseToAnyPublisher()
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


