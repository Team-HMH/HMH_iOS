//
//  ChallegeRepositoryTest.swift
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

/// 홈 이용시간 통계 불러오기  API  데이터 변환 테스트
extension ChallegeRepositoryTests {
    func test_홈이용시간통계불러오기_정상적인변환() {
        let expectedData = DailyChallengeInfo.expectedData
        let resultData = DailyChallengeResult.resultData
        let expectation = XCTestExpectation(description: "홈 이용시간 통계 불러오기 관련 레포지토리 변환이 정상적으로 성공했습니다!")
        
        
        mockService.getDailyChallengeResult = Just(resultData)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
        
        sut.getdailyChallenge()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("홈 이용시간 통계 불러오기 API 변환 중 실패했습니다: 에러 \(error)")
                }
            }, receiveValue: valueHandler(expectation: expectation, expectedValue: expectedData))
            .store(in: cancelBag)
        
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_홈이용시간통계불러오기_네트워크에러발생시_에러반환() {
        
        let testCases = HMHNetworkError.mockNetworkError
        let expectation = XCTestExpectation(description: "에러 발생 시 네트워크 에러 반환")
        
        for expected in testCases {
            mockService.getDailyChallengeResult = Fail(error: expected).eraseToAnyPublisher()
            
            sut.getdailyChallenge()
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
    
    func test_홈이용시간통계불러오기_챌린지를찾을수없는경우_에러반환() {
        // Given
        let message = "챌린지를 찾을 수 없습니다."
        let networkError = HMHNetworkError.invalidResponse(.invalidStatusCode(code: 404, message: message))
        
        mockService.getDailyChallengeResult = Fail(error: networkError)
            .eraseToAnyPublisher()
        
        // When
        let expectedError = ChallengeError.challengeNotFound
        let expectation = XCTestExpectation(description: "챌린지를 찾을 수 없습니다.")
        
        sut.getdailyChallenge()
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


