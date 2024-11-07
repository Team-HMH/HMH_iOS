//
//  ChallegeRepositoryTests.swift
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
import Data

final class ChallegeRepositoryTests: XCTestCase {
    
    var sut: ChallengeRepositoryType!
    var mockService: MockChallengeService!
    var cancelBag: CancelBag!
    
    override func setUpWithError() throws {
        cancelBag = CancelBag()
        mockService = MockChallengeService()
        sut = ChallengeRepository(service: mockService)
    }
    
    override func tearDown() {
        cancelBag = nil
        mockService = nil
        sut = nil
    }
}

extension ChallegeRepositoryTests {
    public func handleCompletion<T: Error & Equatable>(expectedError: T? = nil, expectation: XCTestExpectation) -> (Subscribers.Completion<T>) -> Void {
        return { completion in
            if case .failure(let error) = completion {
                XCTAssertEqual(error, expectedError, "Expected error \(String(describing: expectedError)), but got \(error)")
                expectation.fulfill()
            } else {
                XCTFail("Expected failure with error \(String(describing: expectedError)), but received success")
            }
        }
    }
    
    public func valueHandler<T: Equatable>(expectation: XCTestExpectation, expectedValue: T) -> (T) -> Void {
        return { receivedValue in
            XCTAssertEqual(receivedValue, expectedValue, "Received value \(receivedValue) does not match expected data \(expectedValue)")
            expectation.fulfill()
        }
    }
    
    public func failureExpectedValueHandler<T>() -> (T) -> Void {
        return { _ in XCTFail("Expected failure, but got success") }
    }
}

