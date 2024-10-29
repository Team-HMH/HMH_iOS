//
//  ChallengeService.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Data

typealias ChallengeService = BaseService<ChallengeAPI>

protocol ChallengeServiceType {
    func getdailyChallenge()  -> AnyPublisher<GetChallengeResult, HMHNetworkError>
    func getSuccesChallenge() -> AnyPublisher<ChallengeSuccessResult, HMHNetworkError>
    func createChallenge(data: CreateChallengeRequest) -> AnyPublisher<Void, HMHNetworkError>
    func getLockChallenge() -> AnyPublisher<GetLockResult, HMHNetworkError>
    func postLockChallenge() -> AnyPublisher<Void, HMHNetworkError>
    func deleteApp(data: DeleteAppRequest) -> AnyPublisher<Void, HMHNetworkError>
    func addApp(data: AddAppRequest) -> AnyPublisher<Void, HMHNetworkError>
    func getChallenge() -> AnyPublisher<GetChallengeResult, HMHNetworkError>
}

extension ChallengeService: ChallengeServiceType {
    func getdailyChallenge() -> AnyPublisher<GetChallengeResult, HMHNetworkError> {
        return requestWithResult(.getdailyChallenge, GetChallengeResult.self)
    }
    
    func getSuccesChallenge() -> AnyPublisher<ChallengeSuccessResult, HMHNetworkError> {
        return requestWithResult(.getSuccesChallenge, ChallengeSuccessResult.self)
    }
    
    func createChallenge(data: CreateChallengeRequest) -> AnyPublisher<Void, HMHNetworkError> {
        return requestWithNoResult(.createChallenge(data: data))
    }
    
    func getLockChallenge() -> AnyPublisher<GetLockResult, HMHNetworkError> {
        return requestWithResult(.getLockChallenge, GetLockResult.self)
    }
    
    func postLockChallenge() -> AnyPublisher<Void, HMHNetworkError> {
        return requestWithNoResult(.postLockChallenge)
    }
    
    func deleteApp(data: DeleteAppRequest) -> AnyPublisher<Void, HMHNetworkError> {
        return requestWithNoResult(.deleteApp(data: data))
    }
    
    func addApp(data: AddAppRequest) -> AnyPublisher<Void, HMHNetworkError> {
        return requestWithNoResult(.addApp(data: data))
    }
    
    func getChallenge() -> AnyPublisher<GetChallengeResult, HMHNetworkError> {
        return requestWithResult(.getChallenge, GetChallengeResult.self)
    }
}

struct StubChallengeService: ChallengeServiceType {
    func getdailyChallenge() -> AnyPublisher<GetChallengeResult, HMHNetworkError> {
        return Just(.stub1)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func getSuccesChallenge() -> AnyPublisher<ChallengeSuccessResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func createChallenge(data: CreateChallengeRequest) -> AnyPublisher<Void, HMHNetworkError> {
        return Just(())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func getLockChallenge() -> AnyPublisher<GetLockResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func postLockChallenge() -> AnyPublisher<Void, HMHNetworkError> {
        return Just(())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func deleteApp(data: DeleteAppRequest) -> AnyPublisher<Void, HMHNetworkError> {
        return Just(())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func addApp(data: AddAppRequest) -> AnyPublisher<Void, HMHNetworkError> {
        return Just(())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func getChallenge() -> AnyPublisher<GetChallengeResult, HMHNetworkError> {
        return Just(.stub1)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
}


