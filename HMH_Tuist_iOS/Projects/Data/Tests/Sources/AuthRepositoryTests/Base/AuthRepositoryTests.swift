//
//  AuthRepositoryTests.swift
//  DataTests
//
//  Created by 류희재 on 11/6/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Networks
import Core
import Domain
import Data

final class AuthRepositoryTests: XCTestCase {
    
    var sut: AuthRepositoryType!
    var mockAuthService: MockAuthService!
    var mockOAuthServiceFactory: MockOAuthServiceFactory!
    var cancelBag: CancelBag!
    
    override func setUpWithError() throws {
        cancelBag = CancelBag()
        mockAuthService = MockAuthService()
        mockOAuthServiceFactory = MockOAuthServiceFactory()
        sut = AuthRepository(authService: mockAuthService, oauthServiceFactory: mockOAuthServiceFactory)
    }
    
    override func tearDown() {
        cancelBag = nil
        mockAuthService = nil
        mockOAuthServiceFactory = nil
        sut = nil
    }
}

extension AuthRepositoryTests {
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

