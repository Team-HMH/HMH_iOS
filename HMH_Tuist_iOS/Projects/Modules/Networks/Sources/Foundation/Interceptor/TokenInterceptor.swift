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
    
    private var retryLimit = 2
    let cancelBag = CancelBag()
    
    static let shared = TokenInterceptor(
        service: ReissueAPIService(
            requestHandler: RequestHandler.shared
        )
    )
    
    private let service: ReissueAPIService
    
    private init(service: ReissueAPIService) {
        self.service = service
    }
    
    
    func adapt(_ request: URLRequest) -> AnyPublisher<URLRequest, HMHNetworkError> {
        return Just(request)
            .setFailureType(to: HMHNetworkError.self) // 성공 시 반환될 값의 타입 설정
            .eraseToAnyPublisher() // AnyPublisher로 반환
    }
    
    
    func retry(for session: URLSession) -> AnyPublisher<TokenResult, HMHNetworkError> {
        service.tokenRefresh()
    }
}
