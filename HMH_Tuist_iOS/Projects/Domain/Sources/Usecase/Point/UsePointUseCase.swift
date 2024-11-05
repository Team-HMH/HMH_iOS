//
//  UsePointUseCase.swift
//  Domain
//
//  Created by 이지희 on 11/6/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol UsePointUseCaseType {
    func execute() -> AnyPublisher<UserPointInfo, Error>
}

/// 포인트 사용
public final class UsePointUseCase: UsePointUseCaseType {
    private let repository: PointRepositoryType
    
    public init(repository: PointRepositoryType) {
        self.repository = repository
    }
    
    public func execute() -> AnyPublisher<UserPointInfo, Error> {
        return repository.patchPointUse()
            .eraseToAnyPublisher()
    }
}
