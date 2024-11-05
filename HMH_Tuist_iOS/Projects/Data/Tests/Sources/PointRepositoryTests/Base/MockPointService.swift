//
//  MockPointService.swift
//  Data
//
//  Created by 류희재 on 11/4/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Networks

final public class MockPointService: PointServiceType {
    
    public init() {}

    public var patchPointUseResult:AnyPublisher<UsePointResult, HMHNetworkError>!
    public var getEarnPointResult: AnyPublisher<EarnPointResult, HMHNetworkError>!
    public var getUsagePointResult: AnyPublisher<UsagePointResult, HMHNetworkError>!
    public var getPointListResult: AnyPublisher<PointListResult, HMHNetworkError>!
    public var patchEarnPointResult: AnyPublisher<UserPointResult, HMHNetworkError>!

    public func patchPointUse() -> AnyPublisher<UsePointResult, HMHNetworkError> {
        return patchPointUseResult
    }

    public func getEarnPoint() -> AnyPublisher<EarnPointResult, HMHNetworkError> {
        return getEarnPointResult
    }

    public func getUsagePoint() -> AnyPublisher<UsagePointResult, HMHNetworkError> {
        return getUsagePointResult
    }

    public func getPointList() -> AnyPublisher<PointListResult, HMHNetworkError> {
        return getPointListResult
    }

    public func patchEarnPoint(request: UserPointRequest) -> AnyPublisher<UserPointResult, HMHNetworkError> {
        return patchEarnPointResult
    }
}
