//
//  ChallengeDIContainer.swift
//  HMH-iOS
//
//  Created by 이지희 on 11/27/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Networks

import Core
import Data
import Domain

final class ChallengeDIContainer {
    
    private let service: ChallengeService = ChallengeService()
    
    // MARK: Usecase
    
    private func injectChallengeUseCase() -> ChallengeUseCase {
        return ChallengeUseCase(
            repository: injectChallengeRepository()
        )
    }
    
    // MARK: Repository
    
    private func injectChallengeRepository() -> ChallengeRepository {
        return ChallengeRepository(service: service)
    }
}
