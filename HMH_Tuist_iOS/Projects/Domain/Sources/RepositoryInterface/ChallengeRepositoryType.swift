//
//  ChallengeRepositoryType.swift
//  Domain
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol ChallengeRepositoryType {
    func getdailyChallenge()  -> AnyPublisher<ChallengeDetail, Error>
    func getSuccesChallenge() -> AnyPublisher<[String], Error>
    func createChallenge(period: Int, goalTime: Int) -> AnyPublisher<Void, Error>
    func getLockChallenge() -> AnyPublisher<Bool, Error>
    func postLockChallenge() -> AnyPublisher<Void, Error>
    func deleteApp(appCode: String) -> AnyPublisher<Void, Error>
    func addApp(apps: [App]) -> AnyPublisher<Void, Error>
    func getChallenge() -> AnyPublisher<ChallengeDetail, Error>
}

