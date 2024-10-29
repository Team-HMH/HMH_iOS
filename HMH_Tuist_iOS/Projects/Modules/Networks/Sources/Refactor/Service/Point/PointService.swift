//
//  PointService.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

typealias PointService = BaseService<PointAPI>

protocol PointServiceType {
    func patchPointUse() -> AnyPublisher<UsePointResult, HMHNetworkError>
    func getEarnPoint() -> AnyPublisher<EarnPointResult, HMHNetworkError>
    func getUsagePoint() -> AnyPublisher<UsagePointResult, HMHNetworkError>
    func getPointList() -> AnyPublisher<PointListResult, HMHNetworkError>
    func patchEarnPoint(request: UserPointRequest) -> AnyPublisher<UserPointResult, HMHNetworkError>
}

extension PointService: PointServiceType {
    func patchPointUse() -> AnyPublisher<UsePointResult, HMHNetworkError> {
        requestWithResult(.patchPointUse, UsePointResult.self)
    }
    
    func getEarnPoint() -> AnyPublisher<EarnPointResult, HMHNetworkError> {
        requestWithResult(.getEarnPoint, EarnPointResult.self)
    }
    
    func getUsagePoint() -> AnyPublisher<UsagePointResult, HMHNetworkError> {
        requestWithResult(.getUsagePoint, UsagePointResult.self)
    }
    
    func getPointList() -> AnyPublisher<PointListResult, HMHNetworkError> {
        requestWithResult(.getPointList, PointListResult.self)
    }
    
    func patchEarnPoint(request: UserPointRequest) -> AnyPublisher<UserPointResult, HMHNetworkError> {
        requestWithResult(.patchEarnPoint(request: request), UserPointResult.self)
    }
}

struct StubPointServicee: PointServiceType {
    func patchPointUse() -> AnyPublisher<UsePointResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func getEarnPoint() -> AnyPublisher<EarnPointResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func getUsagePoint() -> AnyPublisher<UsagePointResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func getPointList() -> AnyPublisher<PointListResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func patchEarnPoint(request: UserPointRequest) -> AnyPublisher<UserPointResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    
}

 
