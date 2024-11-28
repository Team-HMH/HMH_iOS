//
//  PointUseCase.swift
//  Domain
//
//  Created by 이지희 on 11/16/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

public protocol PointUseCaseType {
    func getPointStatues() -> AnyPublisher<[PointStatuse], PointError>
    func getEarnPoint() -> AnyPublisher<Int, PointError>
    func getUsagePoint() -> AnyPublisher<Int, PointError>
    func updatePointUse() -> AnyPublisher<UserPointInfo, PointError>
    func earnPoint(point: PointStatuse) -> AnyPublisher<Int, PointError>
}


final class PointUseCase: PointUseCaseType {
    private let repository: PointRepositoryType
    
    public init(repository: PointRepositoryType) {
        self.repository = repository
    }
    
    /// 포인트 뷰 진입 시 포인트 상태 받기
    public func getPointStatues() -> AnyPublisher<[PointStatuse], PointError> {
        return repository.getPointList()
            .map { $0.pointStatuses }
            .eraseToAnyPublisher()
    }
    
    /// 포인트 획득 시, 획득할 포인트
    public func getEarnPoint() -> AnyPublisher<Int, PointError> {
        return repository.getEarnPoint()
            .eraseToAnyPublisher()
    }
    
    /// 포인트 사용 시, 사용할 포인트
    public func getUsagePoint() -> AnyPublisher<Int, PointError> {
        return repository.getUsagePoint()
            .eraseToAnyPublisher()
    }
    
    /// 포인트 사용
    public func updatePointUse() -> AnyPublisher<UserPointInfo, PointError> {
        return repository.patchPointUse()
            .eraseToAnyPublisher()
    }
    
    /// 포인트 획득
    ///  - return : 포인트 획득 후 포인트
    public func earnPoint(point: PointStatuse) -> AnyPublisher<Int, PointError> {
        return repository.patchEarnPoint(date: point.date)
            .eraseToAnyPublisher()
    }
    
}
