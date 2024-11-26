//
//  ChallengeService.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public typealias ChallengeService = BaseService<ChallengeAPI>

public protocol ChallengeServiceType {
    func getDailyChallenge()  -> AnyPublisher<DailyChallengeResult, HMHNetworkError>
    func postSuccesChallenge(request: ChallengeSuccessRequest) -> AnyPublisher<ChallengeSuccessResult, HMHNetworkError>
    func createChallenge(request: CreateChallengeRequest) -> AnyPublisher<Void, HMHNetworkError>
    func getLockChallenge() -> AnyPublisher<GetLockResult, HMHNetworkError>
    func postLockChallenge() -> AnyPublisher<Void, HMHNetworkError>
    func deleteApp(request: DeleteAppRequest) -> AnyPublisher<Void, HMHNetworkError>
    func addApp(request: AddAppRequest) -> AnyPublisher<Void, HMHNetworkError>
    func getChallenge() -> AnyPublisher<GetChallengeResult, HMHNetworkError>
}

extension ChallengeService: ChallengeServiceType {
    public func getDailyChallenge() -> AnyPublisher<DailyChallengeResult, HMHNetworkError> {
        return requestWithResult(.getdailyChallenge)
    }
    
    public func getSuccesChallenge() -> AnyPublisher<ChallengeSuccessResult, HMHNetworkError> {
        return requestWithResult(.postSuccesChallenge)
    }
    
    public func createChallenge(request: CreateChallengeRequest) -> AnyPublisher<Void, HMHNetworkError> {
        return requestWithNoResult(.createChallenge(request: request))
    }
    
    public func getLockChallenge() -> AnyPublisher<GetLockResult, HMHNetworkError> {
        return requestWithResult(.getLockChallenge)
    }
    
    public func postLockChallenge() -> AnyPublisher<Void, HMHNetworkError> {
        return requestWithNoResult(.postLockChallenge)
    }
    
    public func deleteApp(request: DeleteAppRequest) -> AnyPublisher<Void, HMHNetworkError> {
        return requestWithNoResult(.deleteApp(request: request))
    }
    
    public func addApp(request: AddAppRequest) -> AnyPublisher<Void, HMHNetworkError> {
        return requestWithNoResult(.addApp(request: request))
    }
    
    public func getChallenge() -> AnyPublisher<GetChallengeResult, HMHNetworkError> {
        return requestWithResult(.getChallenge)
    }
}

public struct StubChallengeService: ChallengeServiceType {
    public init() {}
    
    public func getDailyChallenge() -> AnyPublisher<DailyChallengeResult, HMHNetworkError> {
        return Just(.stub1)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    public func getSuccesChallenge() -> AnyPublisher<ChallengeSuccessResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    public func createChallenge(request: CreateChallengeRequest) -> AnyPublisher<Void, HMHNetworkError> {
        return Just(())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    public func getLockChallenge() -> AnyPublisher<GetLockResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    public func postLockChallenge() -> AnyPublisher<Void, HMHNetworkError> {
        return Just(())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    public func deleteApp(request: DeleteAppRequest) -> AnyPublisher<Void, HMHNetworkError> {
        return Just(())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    public func addApp(request: AddAppRequest) -> AnyPublisher<Void, HMHNetworkError> {
        return Just(())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    public func getChallenge() -> AnyPublisher<GetChallengeResult, HMHNetworkError> {
        return Just(.stub1)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
}


