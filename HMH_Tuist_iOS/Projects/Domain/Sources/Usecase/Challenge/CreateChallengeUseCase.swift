//
//  CreateChallengeUseCase.swift
//  Domain
//
//  Created by 이지희 on 11/6/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol CreateChallengeUseCaseType {
    func execute(period: Int, goalTime: Int) -> AnyPublisher<Void, ChallengeError>
}

public final class CreateChallengeUseCase: CreateChallengeUseCaseType {
    private let repository: ChallengeRepositoryType
    
    public init(repository: ChallengeRepositoryType) {
        self.repository = repository
    }
    
    public func execute(
        period: Int,
        goalTime: Int
    ) -> AnyPublisher<Void, ChallengeError> {
        return repository.createChallenge(period: period, goalTime: goalTime)
            .eraseToAnyPublisher()
    }
}
