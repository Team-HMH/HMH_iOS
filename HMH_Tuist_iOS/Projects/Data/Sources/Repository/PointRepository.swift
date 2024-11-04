//
//  PointRepository.swift
//  Data
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

public struct PointRepository: PointRepositoryType {
    private let service: PointServiceType
    
    init(service: PointServiceType) {
        self.service = service
    }
    
    public func patchPointUse() -> AnyPublisher<UserPointInfo, PointError> {
        service.patchPointUse()
            .map { $0.toEntity() }
            .mapToDomainError(to: PointError.self)
    }
    
    public func getEarnPoint() -> AnyPublisher<Int, PointError> {
        service.getEarnPoint()
            .map { $0.earnPoint }
            .mapToDomainError(to: PointError.self)
    }
    
    public func getUsagePoint() -> AnyPublisher<Int, PointError> {
        service.getUsagePoint()
            .map { $0.usagePoint }
            .mapToDomainError(to: PointError.self)
    }
    
    public func getPointList() -> AnyPublisher<PointDetail, PointError> {
        service.getPointList()
            .map { $0.toEntity() }
            .mapToDomainError(to: PointError.self)
    }
    
    public func patchEarnPoint(date: String) -> AnyPublisher<Int, PointError> {
        let request = UserPointRequest(challengeDate: date)
        return service.patchEarnPoint(request: request)
            .map { $0.userPoint }
            .mapToDomainError(to: PointError.self)
    }
}

