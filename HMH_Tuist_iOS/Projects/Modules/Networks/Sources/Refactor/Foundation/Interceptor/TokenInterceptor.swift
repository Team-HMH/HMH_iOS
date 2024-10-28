//
//  TokenInterceptor.swift
//  Networks
//
//  Created by 류희재 on 10/28/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

struct TokenInterceptor {
    
    private var retryLimit = 2
    
    static let shared = TokenInterceptor()
    
    private let reissueService: ReissueAPIService
    
    private init() {
        self.reissueService = ReissueAPIService()
    }
    
    
    func adapt(_ request: URLRequest) -> AnyPublisher<URLRequest, HMHNetworkError> {
        // 여기에 필요한 로직을 추가하여 request를 수정할 수 있습니다.
        return Just(request)
            .setFailureType(to: HMHNetworkError.self) // 성공 시 반환될 값의 타입 설정
            .eraseToAnyPublisher() // AnyPublisher로 반환
    }
    
    
    func retry(for session: URLSession) -> AnyPublisher<Void, HMHNetworkError> {
        // 여기에 retry 로직을 추가합니다.
        return Future<Void, HMHNetworkError> { promise in
            // retry 로직을 구현하여 promise를 성공 또는 실패로 완료합니다.
            // 예: promise(.success(())) 또는 promise(.failure(error))
        }
        .eraseToAnyPublisher() // AnyPublisher로 반환
    }
}
