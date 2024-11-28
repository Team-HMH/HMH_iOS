//
//  ChallengeRepository.swift
//  Data
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

public struct ChallengeRepository: ChallengeRepositoryType {
    
    private let service: ChallengeServiceType
    
    public init(service: ChallengeServiceType) {
        self.service = service
    }
    
    public func getdailyChallenge() -> AnyPublisher<DailyChallengeInfo, ChallengeError> {
        service.getDailyChallenge()
            .map { $0.toEntity() }
            .mapToDomainError(to: ChallengeError.self)
    }
    
    public func postSuccesChallenge(sucessInfo: [ChallengeSuccessInfo]) -> AnyPublisher<[String], ChallengeError> {
        let request = ChallengeSuccessRequest(finishedDailyChallenges: sucessInfo.map { $0.toDTO() })
        return service.postSuccesChallenge(request: request)
            .map { $0.statuses }
            .mapToDomainError(to: ChallengeError.self)
    }
    
    public func createChallenge(period: Int, goalTime: Int) -> AnyPublisher<Void, ChallengeError> {
        let request = CreateChallengeRequest(period: period, goalTime: goalTime)
        return service.createChallenge(request: request)
            .map { _ in () }
            .mapToDomainError(to: ChallengeError.self)
    }
    
    public func getLockChallenge() -> AnyPublisher<Bool, ChallengeError> {
        return service.getLockChallenge()
            .map { $0.isLockToday }
            .mapToDomainError(to: ChallengeError.self)
    }
    
    public func postLockChallenge() -> AnyPublisher<Void, ChallengeError> {
        return service.postLockChallenge()
            .map { _ in () }
            .mapToDomainError(to: ChallengeError.self)
    }
    
    public func deleteApp(appCode: String) -> AnyPublisher<Void, ChallengeError> {
        let request = DeleteAppRequest(appCode: appCode)
        return service.deleteApp(request: request)
            .map { _ in () }
            .mapToDomainError(to: ChallengeError.self)
    }
    
    public func addApp(apps: [AppInfo]) -> AnyPublisher<Void, ChallengeError> {
        let request = AddAppRequest(apps: apps.map { $0.toDTO() })
        return service.addApp(request: request)
            .map { _ in () }
            .mapToDomainError(to: ChallengeError.self)
    }
    
    public func getChallenge() -> AnyPublisher<ChallengeDetail, ChallengeError> {
        service.getChallenge()
            .map { $0.toEntity() }
            .mapToDomainError(to: ChallengeError.self)
    }
}
