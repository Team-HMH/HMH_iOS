//
//  ErrorMapper.swift
//  Data
//
//  Created by 류희재 on 11/4/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

//import Foundation
//
//import Domain
//
//class ErrorMapper {
//    static func map<T: DomainError>(message: String, to errorType: T.Type) -> T {
//        return errorType.error(with: message)
//    }
//}


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
                return T.error(with: "알 수 없는 오류")
            }
        }
        .eraseToAnyPublisher()
    }
}
