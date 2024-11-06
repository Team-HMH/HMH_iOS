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
        requestWithResult(.patchPointUse)
    }
    
    public func getEarnPoint() -> AnyPublisher<EarnPointResult, HMHNetworkError> {
        requestWithResult(.getEarnPoint)
    }
    
    public func getUsagePoint() -> AnyPublisher<UsagePointResult, HMHNetworkError> {
        requestWithResult(.getUsagePoint)
    }
    
    public func getPointList() -> AnyPublisher<PointListResult, HMHNetworkError> {
        requestWithResult(.getPointList)
    }
    
    public func patchEarnPoint(request: UserPointRequest) -> AnyPublisher<UserPointResult, HMHNetworkError> {
        requestWithResult(.patchEarnPoint(request: request))
    }
}

public struct StubPointService: PointServiceType {
    
    public init() {}
    
    public func patchPointUse() -> AnyPublisher<UsePointResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    public func getEarnPoint() -> AnyPublisher<EarnPointResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    public func getUsagePoint() -> AnyPublisher<UsagePointResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    public func getPointList() -> AnyPublisher<PointListResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    public func patchEarnPoint(request: UserPointRequest) -> AnyPublisher<UserPointResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
}

 
