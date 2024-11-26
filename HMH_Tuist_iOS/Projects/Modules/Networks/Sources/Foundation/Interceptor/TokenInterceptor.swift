//
//  TokenInterceptor.swift
//  Networks
//
//  Created by 류희재 on 10/28/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine
import Core

class TokenInterceptor {
    
    private var retryCnt = 0
    private var retryLimit = 3
    let cancelBag = CancelBag()
    
    static let shared = TokenInterceptor(
        service: ReissueAPIService()
    )
    
    private let service: ReissueAPIService
    
    private init(service: ReissueAPIService) {
        self.service = service
    }
    
    
    func adapt(_ request: URLRequest) -> AnyPublisher<URLRequest, HMHNetworkError> {
        return Just(request)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    
    func retry(for session: URLSession) -> AnyPublisher<TokenResult, HMHNetworkError> {
        NetworkLogHandler.tokenIntercepterRetryLogging(retryCnt: retryCnt)
        self.retryCnt += 1
        if retryCnt > retryLimit {
            let error = ErrorHandler.handleRetryLimitExceeded()
            retryCnt = 0
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return service.tokenRefresh()
        }
    }
}
