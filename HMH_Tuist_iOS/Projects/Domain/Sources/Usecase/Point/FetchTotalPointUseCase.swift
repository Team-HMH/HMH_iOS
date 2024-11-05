//
//  FetchTotalPointUseCase.swift
//  Domain
//
//  Created by 이지희 on 11/6/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol FetchTotalPointUseCaseType {
    func execute() -> AnyPublisher<Int, Error>
}

/// 유저 포인트
public final class FetchTotalPointUseCase: FetchTotalPointUseCaseType {
    private let repository: PointRepositoryType
    
    public init(repository: PointRepositoryType) {
        self.repository = repository
    }
    
    public func execute() -> AnyPublisher<Int, Error> {
        return repository.getEarnPoint()
            .eraseToAnyPublisher()
    }
}
