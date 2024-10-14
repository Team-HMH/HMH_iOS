//
//  ErrorHandler.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

//class ErrorHandler {
//    static let shared = ErrorHandler()
//    private init () {}
//
//    private let loggingHandler = NetworkLogHandler.shared
//
//    func handleError<T: URLRequestTargetType>(_ target: T, error: HMHNetworkError) -> HMHNetworkError {
////        guard let hmhNetworkError = error as? HMHNetworkError else {
////            return .unknown
////        }
//        loggingHandler.responseError(target, result: error)
//
//        return error
//    }
//}

struct ErrorHandler {
    static func handleError<T: URLRequestTargetType>(_ target: T, error: HMHNetworkError) -> HMHNetworkError { NetworkLogHandler.responseError(target, result: error)
        return error
    }
}

