//
//  CreateChallengeTest.swift
//  DataTests
//
//  Created by 류희재 on 11/5/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Networks
import Core
import Domain

/// 챌린지 생성 API  데이터 변환 테스트
extension ChallegeRepositoryTests {
    func test_챌린지생성_정상적인변환() {
        
        let expectation = XCTestExpectation(description: "챌린지 생성 API 관련 레포지토리 변환이 정상적으로 성공했습니다!")
        
        mockService.createChallengeResult = Just(())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
        
        sut.createChallenge(period: 7, goalTime: 200000)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("챌린지 생성 API 변환 중 실패했습니다: 에러 \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { _ in
                expectation.fulfill()
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_챌린지생성_네트워크에러발생시_에러반환() {
        
        let testCases = HMHNetworkError.mockNetworkError
        let expectation = XCTestExpectation(description: "에러 발생 시 네트워크 에러 반환")
        
        for expected in testCases {
            mockService.createChallengeResult = Fail(error: expected).eraseToAnyPublisher()
            
            sut.createChallenge(period: 7, goalTime: 200000)
                .sink(
                    receiveCompletion: handleCompletion(
                        expectedError: .networkError,
                        expectation: expectation
                    ),
                    receiveValue: failureExpectedValueHandler()
                )
                .store(in: cancelBag)
            
        }
        wait(for: [expectation], timeout: 1.0 * Double(testCases.count))
    }
    
    func test_챌린지생성_챌린지기간이nil일때_에러반환() {
        // Given
        let message = "챌린지 기간은 null일 수 없습니다."
        let networkError = HMHNetworkError.invalidResponse(.invalidStatusCode(code: 400, message: message))
        
        mockService.createChallengeResult = Fail(error: networkError)
            .eraseToAnyPublisher()
        
        // When
        let expectedError = ChallengeError.challengePeriodIsNil
        let expectation = XCTestExpectation(description: message)
        
        sut.createChallenge(period: 7, goalTime: 200000)
            .sink(
                receiveCompletion: handleCompletion(
                    expectedError: expectedError,
                    expectation: expectation
                ),receiveValue: failureExpectedValueHandler()
            )
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_챌린지생성_챌린지기간이유효하지않을때_에러반환() {
        // Given
        let message = "유효한 숫자의 챌린지 기간을 입력해주세요."
        let networkError = HMHNetworkError.invalidResponse(.invalidStatusCode(code: 400, message: message))
        
        mockService.createChallengeResult = Fail(error: networkError)
            .eraseToAnyPublisher()
        
        // When
        let expectedError = ChallengeError.invalidChallengePeriod
        let expectation = XCTestExpectation(description: message)
        
        sut.createChallenge(period: 7, goalTime: 200000)
            .sink(
                receiveCompletion: handleCompletion(
                    expectedError: expectedError,
                    expectation: expectation
                ),receiveValue: failureExpectedValueHandler()
            )
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_챌린지생성_목표시간이nil일경우_에러반환() {
        // Given
        let message = "목표시간은 null일 수 없습니다."
        let networkError = HMHNetworkError.invalidResponse(.invalidStatusCode(code: 400, message: message))
        
        mockService.createChallengeResult = Fail(error: networkError)
            .eraseToAnyPublisher()
        
        // When
        let expectedError = ChallengeError.goalTimeIsNil
        let expectation = XCTestExpectation(description: message)
        
        sut.createChallenge(period: 7, goalTime: 200000)
            .sink(
                receiveCompletion: handleCompletion(
                    expectedError: expectedError,
                    expectation: expectation
                ),receiveValue: failureExpectedValueHandler()
            )
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_챌린지생성_목표시간이이유효하지않을때_에러반환() {
        // Given
        let message = "유효한 숫자의 목표 시간을 입력해주세요."
        let networkError = HMHNetworkError.invalidResponse(.invalidStatusCode(code: 400, message: message))
        
        mockService.createChallengeResult = Fail(error: networkError)
            .eraseToAnyPublisher()
        
        // When
        let expectedError = ChallengeError.invalidGoalTime
        let expectation = XCTestExpectation(description: message)
        
        sut.createChallenge(period: 7, goalTime: 200000)
            .sink(
                receiveCompletion: handleCompletion(
                    expectedError: expectedError,
                    expectation: expectation
                ),receiveValue: failureExpectedValueHandler()
            )
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
