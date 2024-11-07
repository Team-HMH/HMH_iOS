//
//  BaseService.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public final class BaseService<Target: URLRequestTargetType> {
    
    public typealias API = Target
    
    private let requestHandler: RequestHandling
    
    public init(requestHandler: RequestHandling = RequestHandler()) {
        self.requestHandler = requestHandler
    }
    
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
extension BaseService {
    /// 네트워크 응답 처리 메소드
    private func fetchResponse(with target: API) -> AnyPublisher<NetworkResponse, HMHNetworkError> {
        return requestHandler.executeRequest(for: target)
            .handleEvents(receiveSubscription:  {  _ in
                NetworkLogHandler.requestLogging(target)
            }, receiveOutput:  {  response in
                NetworkLogHandler.responseSuccess(target, result: response)
            })
            .mapError { ErrorHandler.handleError(target, error: $0) }
            .eraseToAnyPublisher()
    }
    
    /// 응답 유효성 검사 메서드
    private func validate(response: NetworkResponse, target: API) -> AnyPublisher<Void, HMHNetworkError> {
        guard response.response.isValidateStatus() else {
            // 401 인증 오류 발생 시 토큰 갱신 후 재요청
            if response.response.unAuthorized() {
                return requestHandler.tokenRequest(for: target)
                    .flatMap { _ in
                        self.validate(response: response, target: target)
                    }
                    .eraseToAnyPublisher()
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

