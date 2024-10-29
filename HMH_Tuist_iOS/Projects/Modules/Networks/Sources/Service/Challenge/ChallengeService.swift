//
//  ChallengeService.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

typealias ChallengeService = BaseService<ChallengeAPI>

public protocol ChallengeServiceType {
    func getdailyChallenge()  -> AnyPublisher<GetChallengeResult, HMHNetworkError>
    func getSuccesChallenge() -> AnyPublisher<ChallengeSuccessResult, HMHNetworkError>
    func createChallenge(request: CreateChallengeRequest) -> AnyPublisher<Void, HMHNetworkError>
    func getLockChallenge() -> AnyPublisher<GetLockResult, HMHNetworkError>
    func postLockChallenge() -> AnyPublisher<Void, HMHNetworkError>
    func deleteApp(request: DeleteAppRequest) -> AnyPublisher<Void, HMHNetworkError>
    func addApp(request: AddAppRequest) -> AnyPublisher<Void, HMHNetworkError>
    func getChallenge() -> AnyPublisher<GetChallengeResult, HMHNetworkError>
}

extension ChallengeService: ChallengeServiceType {
    func getdailyChallenge() -> AnyPublisher<GetChallengeResult, HMHNetworkError> {
        return requestWithResult(.getdailyChallenge)
    }
    
    func getSuccesChallenge() -> AnyPublisher<ChallengeSuccessResult, HMHNetworkError> {
        return requestWithResult(.getSuccesChallenge)
    }
    
    func createChallenge(request: CreateChallengeRequest) -> AnyPublisher<Void, HMHNetworkError> {
        return requestWithNoResult(.createChallenge(request: request))
    }
    
    func getLockChallenge() -> AnyPublisher<GetLockResult, HMHNetworkError> {
        return requestWithResult(.getLockChallenge)
    }
    
    func postLockChallenge() -> AnyPublisher<Void, HMHNetworkError> {
        return requestWithNoResult(.postLockChallenge)
    }
    
    func deleteApp(request: DeleteAppRequest) -> AnyPublisher<Void, HMHNetworkError> {
        return requestWithNoResult(.deleteApp(request: request))
    }
    
    func addApp(request: AddAppRequest) -> AnyPublisher<Void, HMHNetworkError> {
        return requestWithNoResult(.addApp(request: request))
    }
    
    func getChallenge() -> AnyPublisher<GetChallengeResult, HMHNetworkError> {
        return requestWithResult(.getChallenge)
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
    
    func createChallenge(request: CreateChallengeRequest) -> AnyPublisher<Void, HMHNetworkError> {
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
    
    func deleteApp(request: DeleteAppRequest) -> AnyPublisher<Void, HMHNetworkError> {
        return Just(())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func addApp(request: AddAppRequest) -> AnyPublisher<Void, HMHNetworkError> {
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


