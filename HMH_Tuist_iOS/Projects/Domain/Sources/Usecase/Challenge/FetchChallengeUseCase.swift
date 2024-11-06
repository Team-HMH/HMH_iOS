//
//  FetchChallengeUseCase.swift
//  Domain
//
//  Created by 이지희 on 11/6/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol FetchChallengeUseCaseType {
    func execute() -> AnyPublisher<ChallengeDetail, ChallengeError>
}

public final class FetchChallengeUseCase: FetchChallengeUseCaseType {
    private let repository: ChallengeRepositoryType
    
    public init(repository: ChallengeRepositoryType) {
        self.repository = repository
    }
    
    public func execute() -> AnyPublisher<ChallengeDetail, ChallengeError> {
        return repository.getChallenge()
            .eraseToAnyPublisher()
    }
}
