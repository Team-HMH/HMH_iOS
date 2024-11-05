//
//  EarnPointUseCase.swift
//  Domain
//
//  Created by 이지희 on 11/6/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol EarnPointUseCaseType {
    func execute(point: PointStatuse) -> AnyPublisher<Int, Error>
}

/// 포인트 얻기
public final class EarnPointUseCase: EarnPointUseCaseType {
    private let repository: PointRepositoryType
    
    public init(repository: PointRepositoryType) {
        self.repository = repository
    }
    
    /// 포인트 얻기 후 총 포인트
    public func execute(point: PointStatuse) -> AnyPublisher<Int, Error> {
        return repository.patchEarnPoint(date: point.date)
            .eraseToAnyPublisher()
    }
}

