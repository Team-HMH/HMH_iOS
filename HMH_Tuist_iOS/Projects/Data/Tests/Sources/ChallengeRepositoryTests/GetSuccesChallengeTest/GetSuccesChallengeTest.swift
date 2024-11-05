//
//  GetSuccesChallengeTest.swift
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

/// 챌린지 성공 여부 리스트 전송  API  데이터 변환 테스트
extension ChallegeRepositoryTests {
    func test_챌린지성공여부리스트전송_정상적인변환() {
        let testCases = Array(zip(ChallengeSuccessResult.expectedData, ChallengeSuccessResult.resultData))
        let expectation = XCTestExpectation(description: "챌린지 성공 여부 리스트 전송 관련 레포지토리 변환이 정상적으로 성공했습니다!")
        expectation.expectedFulfillmentCount = testCases.count
        
        for (expectedData, resultData) in testCases {
            mockService.getSuccesChallengeResult = Just(resultData)
                .setFailureType(to: HMHNetworkError.self)
                .eraseToAnyPublisher()
            
            sut.getSuccesChallenge()
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTFail("챌린지 성공 여부 리스트 전송 API 변환 중 실패했습니다: 에러 \(error)")
                    }
                }, receiveValue: valueHandler(expectation: expectation, expectedValue: expectedData))
                .store(in: cancelBag)
        }
        
        wait(for: [expectation], timeout: 1.0 * Double(testCases.count))
    }
    
    func test_챌린지성공여부리스트전송_네트워크에러발생시_에러반환() {
        
        let testCases = HMHNetworkError.mockNetworkError
        let expectation = XCTestExpectation(description: "에러 발생 시 네트워크 에러 반환")
        
        for expected in testCases {
            mockService.getSuccesChallengeResult = Fail(error: expected).eraseToAnyPublisher()
            
            sut.getSuccesChallenge()
                .sink(
                    receiveCompletion: handleCompletion(
                        expectedError: .networkError,
                        expectation: expectation
                    ),
                    receiveValue: failureExpectedValueHandler()
                )
                .store(in: cancelBag)
            
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
