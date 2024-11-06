//
//  MockChallengeService.swift
//  Data
//
//  Created by 류희재 on 11/5/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

final public class MockChallengeService: ChallengeServiceType {
    
    public init() {}
    
    public var getDailyChallengeResult:AnyPublisher<DailyChallengeResult, HMHNetworkError>!
    public var getSuccesChallengeResult:AnyPublisher<ChallengeSuccessResult, HMHNetworkError>!
    public var createChallengeResult:AnyPublisher<Void, HMHNetworkError>!
    public var getLockChallengeResult:AnyPublisher<GetLockResult, HMHNetworkError>!
    public var postLockChallengeResult:AnyPublisher<Void, HMHNetworkError>!
    public var deleteAppResult:AnyPublisher<Void, HMHNetworkError>!
    public var addAppResult:AnyPublisher<Void, HMHNetworkError>!
    public var getChallengeResult:AnyPublisher<GetChallengeResult, HMHNetworkError>!
    
    
    public func getDailyChallenge() -> AnyPublisher<DailyChallengeResult, HMHNetworkError> {
        return getDailyChallengeResult
    }
    
    public func getSuccesChallenge() -> AnyPublisher<ChallengeSuccessResult, HMHNetworkError> {
        return getSuccesChallengeResult
    }
    
    public func createChallenge(request: CreateChallengeRequest) -> AnyPublisher<Void, HMHNetworkError> {
        return createChallengeResult
    }
    
    public func getLockChallenge() -> AnyPublisher<GetLockResult, HMHNetworkError> {
        return getLockChallengeResult
    }
    
    public func postLockChallenge() -> AnyPublisher<Void, HMHNetworkError> {
        return postLockChallengeResult
    }
    
    public func deleteApp(request: DeleteAppRequest) -> AnyPublisher<Void, HMHNetworkError> {
        return deleteAppResult
    }
    
    public func addApp(request: AddAppRequest) -> AnyPublisher<Void, HMHNetworkError> {
        return addAppResult
    }
    
    public func getChallenge() -> AnyPublisher<GetChallengeResult, HMHNetworkError> {
        return getChallengeResult
    }
}

