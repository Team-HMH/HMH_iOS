//
//  PointService.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public typealias PointService = BaseService<PointAPI>

public protocol PointServiceType {
    func patchPointUse() -> AnyPublisher<UsePointResult, HMHNetworkError>
    func getEarnPoint() -> AnyPublisher<EarnPointResult, HMHNetworkError>
    func getUsagePoint() -> AnyPublisher<UsagePointResult, HMHNetworkError>
    func getPointList() -> AnyPublisher<PointListResult, HMHNetworkError>
    func patchEarnPoint(request: UserPointRequest) -> AnyPublisher<UserPointResult, HMHNetworkError>
}

extension PointService: PointServiceType {
    public func patchPointUse() -> AnyPublisher<UsePointResult, HMHNetworkError> {
        sendRequest(.patchPointUse)
    }
    
    public func getEarnPoint() -> AnyPublisher<EarnPointResult, HMHNetworkError> {
        sendRequest(.getEarnPoint)
    }
    
    public func getUsagePoint() -> AnyPublisher<UsagePointResult, HMHNetworkError> {
        sendRequest(.getUsagePoint)
    }
    
    public func getPointList() -> AnyPublisher<PointListResult, HMHNetworkError> {
        sendRequest(.getPointList)
    }
    
    public func patchEarnPoint(request: UserPointRequest) -> AnyPublisher<UserPointResult, HMHNetworkError> {
        sendRequest(.patchEarnPoint(request: request))
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

 
