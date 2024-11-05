//
//  GetUsagePointTest.swift
//  DataTests
//
//  Created by 류희재 on 11/5/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

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

/// 사용할 포인트 반환 API  데이터 변환 테스트
extension PointRepositoryTest {
    func test_사용할포인트반환_정상적인변환() {
        // Given
        let expectedData = 100
        mockService.getUsagePointResult = Just(.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
        
        // When
        let expectation = XCTestExpectation(description: "포인트 사용 관련 레포지토리 변환이 정상적으로 성공했습니다!")
        sut.getUsagePoint()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("받을 포인트 반환 API 변환 중 실패했습니다: 에러 \(error)")
                }
            }, receiveValue: valueHandler(expectation: expectation, expectedValue: expectedData))
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_사용할포인트반환_네트워크에러발생시_에러반환() {
        // Given
        mockService.getUsagePointResult = Fail(error: HMHNetworkError.testErr)
            .eraseToAnyPublisher()
        
        // When
        let expectedError = PointError.networkError
        let expectation = XCTestExpectation(description: "에러 발생 시 에러 반환")
        
        sut.getUsagePoint()
            .sink(
                receiveCompletion: handleCompletion(
                    expectedError: expectedError,
                    expectation: expectation
                ),
                receiveValue: failureExpectedValueHandler()
            )
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_사용할포인트반환_유저가존재하지않을경우_에러반환() {
        // Given
        let message = "존재하지 않는 유저"
        let networkError = HMHNetworkError.invalidResponse(.invalidStatusCode(code: 404, message: message))
        
        mockService.getUsagePointResult = Fail(error: networkError)
            .eraseToAnyPublisher()
        
        // When
        let expectedError = PointError.userNotFound
        let expectation = XCTestExpectation(description: "존재하지 않는 유저")
        
        sut.getUsagePoint()
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






