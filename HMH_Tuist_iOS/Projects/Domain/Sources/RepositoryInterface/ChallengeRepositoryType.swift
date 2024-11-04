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
    func getdailyChallenge()  -> AnyPublisher<ChallengeDetail, ChallengeError>
    func getSuccesChallenge() -> AnyPublisher<[String], ChallengeError>
    func createChallenge(period: Int, goalTime: Int) -> AnyPublisher<Void, ChallengeError>
    func getLockChallenge() -> AnyPublisher<Bool, ChallengeError>
    func postLockChallenge() -> AnyPublisher<Void, ChallengeError>
    func deleteApp(appCode: String) -> AnyPublisher<Void, ChallengeError>
    func addApp(apps: [AppInfo]) -> AnyPublisher<Void, ChallengeError>
    func getChallenge() -> AnyPublisher<ChallengeDetail, ChallengeError>
}

