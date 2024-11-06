//
//  PostSucessChallengeUseCase.swift
//  Domain
//
//  Created by 이지희 on 11/6/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol PostSucessChallengeUseCaseType {
    func execute(dailyChallengeInfo: [DailyChallengeInfo]) -> AnyPublisher<[String], ChallengeError>
}

public final class PostSucessChallengeUseCase: PostSucessChallengeUseCaseType {
    private let repository: ChallengeRepositoryType
    
    public init(repository: ChallengeRepositoryType) {
        self.repository = repository
    }
    
    public func execute(dailyChallengeInfo: [DailyChallengeInfo]) -> AnyPublisher<[String], ChallengeError> {
        return repository.postSucessChallenge(dailyChallengeInfo: dailyChallengeInfo)
            .eraseToAnyPublisher()
    }
}
