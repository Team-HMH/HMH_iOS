//
//  ErrorMapper.swift
//  Data
//
//  Created by 류희재 on 11/4/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

extension Publisher where Failure == HMHNetworkError {
    func mapToDomainError<T: DomainError>(to errorType: T.Type) -> AnyPublisher<Output, T> {
        self.mapError { networkError in
            if case let .invalidResponse(responseError) = networkError,
               let errorMessage = responseError.invalidStatusCodeMessage() {
                return T.error(with: errorMessage)
            } else {
                return T.error(with: "네트워크 오류입니다")
            }
        }
        .eraseToAnyPublisher()
    }
}
