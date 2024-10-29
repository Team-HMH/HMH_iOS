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
    
    public func patchPointUse() -> AnyPublisher<UserPointInfo, Error> {
        service.patchPointUse()
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    public func getEarnPoint() -> AnyPublisher<Int, Error> {
        service.getEarnPoint()
            .map { $0.earnPoint }
            .mapToGeneralError()
    }
    
    public func getUsagePoint() -> AnyPublisher<Int, Error> {
        service.getUsagePoint()
            .map { $0.usagePoint }
            .mapToGeneralError()
    }
    
    public func getPointList() -> AnyPublisher<PointDetail, Error> {
        service.getPointList()
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    public func patchEarnPoint(date: String) -> AnyPublisher<Int, Error> {
        let request = UserPointRequest(challengeDate: date)
        return service.patchEarnPoint(request: request)
            .map { $0.userPoint }
            .mapToGeneralError()
    }
}

