//
//  RequestValidatorTest.swift
//  NetworksTests
//
//  Created by 류희재 on 11/10/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Core
import Networks


class RequestDataValidatorTests: XCTestCase {
    
    var cancelBag: CancelBag!
    var mockURL = URL(string: "https://example.com")!
    
    override func setUpWithError() throws {
        cancelBag = CancelBag()
    }
    
    override func tearDown() {
        cancelBag = nil
    }
    
    public func validateWithParameters(
        parameters: Parameters?,
        url: URL?,
        expectedError: HMHNetworkError.ParameterEncodingError? = nil,
        expectation: XCTestExpectation,
        validationBlock: @escaping ((Parameters, URL) -> Void) = {_, _ in}) {

            RequestDataValidator.validateWithParameters(parameters, url)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTAssertEqual(error, expectedError)
                        expectation.fulfill()
                    } else {
                        if case .failure(let error) = completion {
                            XCTFail("Expected success, but got error: \(error)")
                        }
                    }
                }, receiveValue: validationBlock)
                .store(in: cancelBag)
        }
    
    public func validateWithEncodableParameters(
        parameters: Encodable?,
        url: URL?,
        expectedError: HMHNetworkError.ParameterEncodingError? = nil,
        expectationDescription: String,
        validationBlock: @escaping ((Encodable, URL) -> Void)) {
            let expectation = XCTestExpectation(description: expectationDescription)
            
            RequestDataValidator.validateWithEncodable(parameters, url)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTAssertEqual(error, expectedError)
                        expectation.fulfill()
                    } else {
                        if case .failure(let error) = completion {
                            XCTFail("Expected success, but got error: \(error)")
                        }
                    }
                }, receiveValue: validationBlock)
                .store(in: cancelBag)
            
            wait(for: [expectation], timeout: 1.0)
        }
}
