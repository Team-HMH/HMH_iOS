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

struct ChallengeRepository: ChallengeRepositoryType {
    
    private let service: ChallengeServiceType
    
    init(service: ChallengeServiceType) {
        self.service = service
    }
    
    func getdailyChallenge() -> AnyPublisher<ChallengeDetail, ChallengeError> {
        service.getdailyChallenge()
            .map { $0.toEntity() }
            .mapToDomainError(to: ChallengeError.self)
    }
    
    func getSuccesChallenge() -> AnyPublisher<[String], ChallengeError> {
        service.getSuccesChallenge()
            .map { $0.statuses }
            .mapToDomainError(to: ChallengeError.self)
    }
    
    func createChallenge(period: Int, goalTime: Int) -> AnyPublisher<Void, ChallengeError> {
        let request = CreateChallengeRequest(period: period, goalTime: goalTime)
        return service.createChallenge(request: request)
            .map { _ in () }
            .mapToDomainError(to: ChallengeError.self)
    }
    
    func getLockChallenge() -> AnyPublisher<Bool, ChallengeError> {
        return service.getLockChallenge()
            .map { $0.isLockToday }
            .mapToDomainError(to: ChallengeError.self)
    }
    
    func postLockChallenge() -> AnyPublisher<Void, ChallengeError> {
        return service.postLockChallenge()
            .map { _ in () }
            .mapToDomainError(to: ChallengeError.self)
    }
    
    func deleteApp(appCode: String) -> AnyPublisher<Void, ChallengeError> {
        let request = DeleteAppRequest(appCode: appCode)
        return service.deleteApp(request: request)
            .map { _ in () }
            .mapToDomainError(to: ChallengeError.self)
    }
    
    func addApp(apps: [AppInfo]) -> AnyPublisher<Void, ChallengeError> {
        let request = AddAppRequest(apps: apps.map { $0.toDTO() })
        return service.addApp(request: request)
            .map { _ in () }
            .mapToDomainError(to: ChallengeError.self)
    }
    
    func getChallenge() -> AnyPublisher<ChallengeDetail, ChallengeError> {
        service.getChallenge()
            .map { $0.toEntity() }
            .mapToDomainError(to: ChallengeError.self)
    }
}
