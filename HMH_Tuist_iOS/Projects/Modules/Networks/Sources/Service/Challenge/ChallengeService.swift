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
    func createChallenge(request: CreateChallengeRequest) -> AnyPublisher<VoidResult, HMHNetworkError>
    func getLockChallenge() -> AnyPublisher<GetLockResult, HMHNetworkError>
    func postLockChallenge() -> AnyPublisher<VoidResult, HMHNetworkError>
    func deleteApp(request: DeleteAppRequest) -> AnyPublisher<VoidResult, HMHNetworkError>
    func addApp(request: AddAppRequest) -> AnyPublisher<VoidResult, HMHNetworkError>
    func getChallenge() -> AnyPublisher<GetChallengeResult, HMHNetworkError>
}

extension ChallengeService: ChallengeServiceType {
    public func getdailyChallenge() -> AnyPublisher<GetChallengeResult, HMHNetworkError> {
        return sendRequest(.getdailyChallenge)
    }
    
    public func getSuccesChallenge() -> AnyPublisher<ChallengeSuccessResult, HMHNetworkError> {
        return sendRequest(.getSuccesChallenge)
    }
    
    public func createChallenge(request: CreateChallengeRequest) -> AnyPublisher<VoidResult, HMHNetworkError> {
        return sendRequest(.createChallenge(request: request))
    }
    
    public func getLockChallenge() -> AnyPublisher<GetLockResult, HMHNetworkError> {
        return sendRequest(.getLockChallenge)
    }
    
    public func postLockChallenge() -> AnyPublisher<VoidResult, HMHNetworkError> {
        return sendRequest(.postLockChallenge)
    }
    
    public func deleteApp(request: DeleteAppRequest) -> AnyPublisher<VoidResult, HMHNetworkError> {
        return sendRequest(.deleteApp(request: request))
    }
    
    public func addApp(request: AddAppRequest) -> AnyPublisher<VoidResult, HMHNetworkError> {
        return sendRequest(.addApp(request: request))
    }
    
    public func getChallenge() -> AnyPublisher<GetChallengeResult, HMHNetworkError> {
        return sendRequest(.getChallenge)
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
    
    func createChallenge(request: CreateChallengeRequest) -> AnyPublisher<VoidResult, HMHNetworkError> {
        return Just(VoidResult())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func getLockChallenge() -> AnyPublisher<GetLockResult, HMHNetworkError> {
        return Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func postLockChallenge() -> AnyPublisher<VoidResult, HMHNetworkError> {
        return Just(VoidResult())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func deleteApp(request: DeleteAppRequest) -> AnyPublisher<VoidResult, HMHNetworkError> {
        return Just(VoidResult())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func addApp(request: AddAppRequest) -> AnyPublisher<VoidResult, HMHNetworkError> {
        return Just(VoidResult())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func getChallenge() -> AnyPublisher<GetChallengeResult, HMHNetworkError> {
        return Just(.stub1)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
    }
}


