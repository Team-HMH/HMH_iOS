//
//  getEarnPointTest.swift
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

/// 받을 포인트 반환 API  데이터 변환 테스트
extension PointRepositoryTest {
    func test_받을포인트반환_정상적인변환() {
        let testCases = Array(zip(EarnPointResult.expectedData, EarnPointResult.resultData))
        let expectation = XCTestExpectation(description: "받을 포인트 반환 관련 레포지토리 변환이 정상적으로 성공했습니다!")
        expectation.expectedFulfillmentCount = testCases.count
        
        for (expectedData, resultData) in testCases {
            mockService.getEarnPointResult = Just(resultData)
                .setFailureType(to: HMHNetworkError.self)
                .eraseToAnyPublisher()
            
            sut.getEarnPoint()
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTFail("받을 포인트 반환 API 변환 중 실패했습니다: 에러 \(error)")
                    }
                }, receiveValue: valueHandler(expectation: expectation, expectedValue: expectedData))
                .store(in: cancelBag)
        }
        
        wait(for: [expectation], timeout: 1.0 * Double(testCases.count))
    }
    
    func test_받을포인트반환_네트워크에러발생시_에러반환() {
        
        let testCases = HMHNetworkError.mockNetworkError
        let expectation = XCTestExpectation(description: "에러 발생 시 네트워크 에러 반환")
        
        for expected in testCases {
            mockService.patchPointUseResult = Fail(error: expected).eraseToAnyPublisher()
            
            sut.patchPointUse()
                .sink(
                    receiveCompletion: handleCompletion(
                        expectedError: PointError.networkError,
                        expectation: expectation
                    ),
                    receiveValue: failureExpectedValueHandler()
                )
                .store(in: cancelBag)
            
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_받을포인트반환_유저가존재하지않을경우_에러반환() {
        // Given
        let message = "존재하지 않는 유저"
        let networkError = HMHNetworkError.invalidResponse(.invalidStatusCode(code: 404, message: message))
        
        mockService.patchPointUseResult = Fail(error: networkError)
            .eraseToAnyPublisher()
        
        // When
        let expectedError = PointError.userNotFound
        let expectation = XCTestExpectation(description: message)
        
        sut.patchPointUse()
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
