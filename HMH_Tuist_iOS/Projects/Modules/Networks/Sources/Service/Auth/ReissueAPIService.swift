//
//  ReissueService.swift
//  Networks
//
//  Created by 류희재 on 10/28/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

typealias ReissueAPIService = BaseService<AuthAPI>

protocol ReissueAPIServiceType {
    func tokenRefresh() -> AnyPublisher<TokenResult, HMHNetworkError>
}

extension ReissueAPIService: ReissueAPIServiceType {
    func tokenRefresh() -> AnyPublisher<TokenResult, HMHNetworkError> {
        requestWithResult(.tokeRefresh)
    }
    
}

struct StubReissueAPIService: ReissueAPIServiceType {
    func tokenRefresh() -> AnyPublisher<TokenResult, HMHNetworkError> {
        return Just(TokenResult(accessToken: "",refreshToken: ""))
        .setFailureType(to: HMHNetworkError.self)
        .eraseToAnyPublisher()
    }
}
