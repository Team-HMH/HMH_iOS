//
//  RequestHandling.swift
//  Networks
//
//  Created by 류희재 on 10/30/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol RequestHandling {
    func executeRequest<T: URLRequestTargetType>(for target: T) -> AnyPublisher<NetworkResponse, HMHNetworkError>
    func tokenRequest<T: URLRequestTargetType>(for target: T) -> AnyPublisher<NetworkResponse, HMHNetworkError>
}
