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
    
    func getdailyChallenge() -> AnyPublisher<ChallengeDetail, Error> {
        service.getdailyChallenge()
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    func getSuccesChallenge() -> AnyPublisher<[String], Error> {
        service.getSuccesChallenge()
            .map { $0.statuses }
            .mapToGeneralError()
    }
    
    func createChallenge(period: Int, goalTime: Int) -> AnyPublisher<Void, Error> {
        let request = CreateChallengeRequest(period: period, goalTime: goalTime)
        return service.createChallenge(request: request)
            .asVoidWithGeneralError()
    }
    
    func getLockChallenge() -> AnyPublisher<Bool, Error> {
        return service.getLockChallenge()
            .map { $0.isLockToday }
            .mapToGeneralError()
    }
    
    func postLockChallenge() -> AnyPublisher<Void, Error> {
        return service.postLockChallenge()
            .asVoidWithGeneralError()
    }
    
    func deleteApp(appCode: String) -> AnyPublisher<Void, Error> {
        let request = DeleteAppRequest(appCode: appCode)
        return service.deleteApp(request: request)
            .asVoidWithGeneralError()
    }
    
    func addApp(apps: [AppInfo]) -> AnyPublisher<Void, Error> {
        let request = AddAppRequest(apps: apps.map { $0.toDTO() })
        return service.addApp(request: request)
            .asVoidWithGeneralError()
    }
    
    func getChallenge() -> AnyPublisher<ChallengeDetail, Error> {
        service.getChallenge()
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
}
