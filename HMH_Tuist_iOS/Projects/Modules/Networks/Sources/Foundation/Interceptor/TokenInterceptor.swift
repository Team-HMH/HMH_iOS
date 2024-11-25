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

struct TokenInterceptor {
    
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
    
    
    func retry(for session: URLSession, retryCnt: Int) -> AnyPublisher<TokenResult, HMHNetworkError> {
        
        if retryCnt > retryLimit {
            let error = ErrorHandler.handleRetryLimitExceeded()
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return service.tokenRefresh()
        }
    }
}
