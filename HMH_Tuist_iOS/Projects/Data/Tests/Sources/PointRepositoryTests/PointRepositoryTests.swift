//
//  PointRepositoryTests.swift
//  DataTests
//
//  Created by 류희재 on 11/4/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Networks
import Core
import Domain
import Data

final class PointRepositoryTest: XCTestCase {
    
    var sut: PointRepositoryType!
    var mockService: MockPointService!
    var cancelBag: CancelBag!
    
    override func setUpWithError() throws {
        cancelBag = CancelBag()
        mockService = MockPointService()
        sut = PointRepository(service: mockService)
    }
    
    override func tearDown() {
        cancelBag = nil
        mockService = nil
        sut = nil
    }
}

extension PointRepositoryTest {
    public func handleCompletion<T: Error & Equatable>(expectedError: T, expectation: XCTestExpectation) -> (Subscribers.Completion<T>) -> Void {
        return { completion in
            if case .failure(let error) = completion {
                XCTAssertEqual(error, expectedError, "Expected error \(expectedError), but got \(error)")
                expectation.fulfill()
            } else {
                XCTFail("Expected failure with error \(expectedError), but received success")
            }
        }
    }
    
    
    // 헬퍼 메서드: receiveValue 처리
    public func valueHandler<T: Equatable>(expectation: XCTestExpectation, expectedValue: T) -> (T) -> Void {
        return { receivedValue in
            XCTAssertEqual(receivedValue, expectedValue)
            expectation.fulfill()
        }
    }
    
    public func failureExpectedValueHandler<T>() -> (T) -> Void {
        return { _ in XCTFail("Expected failure, but got success") }
    }
}
