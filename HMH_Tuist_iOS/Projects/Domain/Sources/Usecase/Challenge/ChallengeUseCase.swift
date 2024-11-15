//
//  ChallengeUseCase.swift
//  Domain
//
//  Created by 이지희 on 11/16/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

public protocol ChallngeUseCaseType {
    func createChallenge(
        period: Int,
        goalTime: Int
    ) -> AnyPublisher<Void, ChallengeError>
    
    func getChallenge() -> AnyPublisher<ChallengeDetail, ChallengeError>
}

final class ChallengeUseCase: ChallngeUseCaseType {
    private let repository: ChallengeRepositoryType
    
    public init(repository: ChallengeRepositoryType) {
        self.repository = repository
    }
    
    public func createChallenge(
        period: Int,
        goalTime: Int
    ) -> AnyPublisher<Void, ChallengeError> {
        return repository.createChallenge(period: period, goalTime: goalTime)
            .eraseToAnyPublisher()
    }
    
    public func getChallenge() -> AnyPublisher<ChallengeDetail, ChallengeError> {
        repository.getChallenge()
            .flatMap { [weak self] challengeDetail -> AnyPublisher<ChallengeDetail, ChallengeError> in
                guard let self = self else {
                    return Fail(error: ChallengeError.networkError).eraseToAnyPublisher()
                }
                
                let noneDates = self.findNoneDates(
                    statuses: challengeDetail.statuses.map { $0.rawValue },
                    todayIndex: challengeDetail.todayIndex,
                    startDate: challengeDetail.startDate
                )
                
                guard !noneDates.isEmpty else {
                    // NONE 상태가 없으면 그대로 반환
                    return Just(challengeDetail)
                        .setFailureType(to: ChallengeError.self)
                        .eraseToAnyPublisher()
                }
                
                let successInfos = noneDates.map { date in
                    ChallengeSuccessInfo(challengeDate: date, isSuccess: true)
                }
                
                return self.sendSucessChallenge(challengeSucessInfo: successInfos)
                    .flatMap { _ -> AnyPublisher<ChallengeDetail, ChallengeError> in
                        // 서버 전송 후 상태를 업데이트하여 반환
                        let updatedStatuses = challengeDetail.statuses.enumerated().map { index, status -> PointStatusEnum in
                            if noneDates.contains(self.dateString(for: index, startDate: challengeDetail.startDate)) {
                                return .unearned
                            }
                            return status
                        }
                        
                        let updatedChallenge = ChallengeDetail(
                            statuses: updatedStatuses,
                            todayIndex: challengeDetail.todayIndex,
                            startDate: challengeDetail.startDate,
                            challengeInfo: challengeDetail.challengeInfo
                        )
                        
                        return Just(updatedChallenge)
                            .setFailureType(to: ChallengeError.self)
                            .eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func sendSucessChallenge(challengeSucessInfo: [ChallengeSuccessInfo]) -> AnyPublisher<[String], ChallengeError> {
        return repository.postSuccesChallenge(sucessInfo: challengeSucessInfo)
            .eraseToAnyPublisher()
    }
    
    private func findNoneDates(statuses: [String], todayIndex: Int, startDate: String) -> [String] {
        var dates: [String] = []
        
        let challengeDays = statuses.count
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let start = dateFormatter.date(from: startDate) else {
            print("Invalid start date format")
            return dates
        }
        
        let calendar = Calendar.current
        
        if todayIndex > 0 {
            for index in 0 ..< todayIndex {
                if statuses[index] == "NONE" {
                    if let newDate = calendar.date(byAdding: .day, value: index, to: start) {
                        let formattedDate = dateFormatter.string(from: newDate)
                        dates.append(formattedDate)
                    }
                }
            }
        } else {
            for index in 0 ..< challengeDays {
                if statuses[index] == "NONE" {
                    if let newDate = calendar.date(byAdding: .day, value: index, to: start) {
                        let formattedDate = dateFormatter.string(from: newDate)
                        dates.append(formattedDate)
                    }
                }
            }
        }
        
        return dates
    }
    
    private func dateString(for index: Int, startDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let start = dateFormatter.date(from: startDate),
              let newDate = Calendar.current.date(byAdding: .day, value: index, to: start) else {
            return ""
        }
        return dateFormatter.string(from: newDate)
    }
}
