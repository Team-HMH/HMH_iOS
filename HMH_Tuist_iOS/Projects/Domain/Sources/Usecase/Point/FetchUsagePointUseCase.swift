//
//  GetUsagePointUseCase.swift
//  Domain
//
//  Created by 이지희 on 11/6/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol FetchUsagePointUseCaseType {
    func execute() -> AnyPublisher<Int, PointError>
}

/// 사용할 포인트 조회
public final class FetchUsagePointUseCase: FetchUsagePointUseCaseType {
    private let repository: PointRepositoryType
    
    public init(repository: PointRepositoryType) {
        self.repository = repository
    }
    
    public func execute() -> AnyPublisher<Int, PointError> {
        return repository.getUsagePoint()
            .eraseToAnyPublisher()
    }
}
