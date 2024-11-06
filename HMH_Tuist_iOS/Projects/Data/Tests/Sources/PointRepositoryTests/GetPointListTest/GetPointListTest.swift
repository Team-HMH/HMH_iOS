//
//  GetPointListTest.swift
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

/// 포인트 수령 여부 조회 API  데이터 변환 테스트
extension PointRepositoryTest {
    func test_포인트수령여부조회_정상적인변환() {
        let testCases = Array(zip(PointDetail.expectedData, PointListResult.resultData))
        let expectation = XCTestExpectation(description: "포인트 수령 여부 조회 관련 레포지토리 변환이 정상적으로 성공했습니다!")
        expectation.expectedFulfillmentCount = testCases.count
        
        for (expectedData, resultData) in testCases {
            mockService.getPointListResult = Just(resultData)
                .setFailureType(to: HMHNetworkError.self)
                .eraseToAnyPublisher()
            
            sut.getPointList()
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTFail("포인트 수령 여부 조회 API 변환 중 실패했습니다: 에러 \(error)")
                    }
                }, receiveValue: valueHandler(expectation: expectation, expectedValue: expectedData))
                .store(in: cancelBag)
        }
        
        wait(for: [expectation], timeout: 1.0 * Double(testCases.count))
    }
    
    func test_포인트수령여부조회_네트워크에러발생시_에러반환() {
        
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

    func test_포인트수령여부조회_챌린지를찾을수없는경우_에러반환() {
        // Given
        let message = "챌린지를 찾을 수 없습니다."
        let networkError = HMHNetworkError.invalidResponse(.invalidStatusCode(code: 404, message: message))
        
        mockService.getPointListResult = Fail(error: networkError)
            .eraseToAnyPublisher()
        
        // When
        let expectedError = PointError.challengeNotFound
        let expectation = XCTestExpectation(description: "챌린지를 찾을 수 없습니다.")
        
        sut.getPointList()
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
