//
//  ValidateParameterTest.swift
//  NetworksTests
//
//  Created by 류희재 on 11/12/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Core
import Networks

extension RequestDataValidatorTests {
    func test_validateWithParameters_정상적인파라미터와URL일때_정상적인변환() {
        let requestParameter = ParameterValidatorMockData.validParameter
        
        let expectation = XCTestExpectation(description: "유효한 파라미터와 URL입니다")
        
        RequestDataValidator.validateWithParameters(requestParameter, mockURL)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but got error: \(error)")
                }
            }, receiveValue: { resultParameters, resultURL in
                XCTAssertEqual(resultParameters["username"] as? String, "hellohidi")
                XCTAssertEqual(resultURL.absoluteString, "https://example.com")
                expectation.fulfill()
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_validateWithParameters_파라미터가Nil일때_emptyParameters_에러반환() {
        let requestParameter = ParameterValidatorMockData.nilParameters
        
        let expectation = XCTestExpectation(description: "Nil parameters should fail")
        
        RequestDataValidator.validateWithParameters(requestParameter, mockURL)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .emptyParameters)
                    expectation.fulfill()
                }
            }, receiveValue: { _, _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_validateWithParameters_URL이Nil일때_missingURL_에러반환() {
        let requestParameter = ParameterValidatorMockData.validParameter
        
        let expectation = XCTestExpectation(description: "Nil URL should fail")
        
        RequestDataValidator.validateWithParameters(requestParameter, nil)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .missingURL)
                    expectation.fulfill()
                }
            }, receiveValue: { _, _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_validateWithParameters_파라미터와URL둘다Nil일때_emptyParameters_에러반환() {
        let requestParameter = ParameterValidatorMockData.nilParameters
        
        let expectation = XCTestExpectation(description: "Nil URL should fail")
        
        RequestDataValidator.validateWithParameters(requestParameter, nil)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .missingURL) //URL 체크가 먼저기때문
                    expectation.fulfill()
                }
            }, receiveValue: { _, _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_validateWithParameters_파라미터가비어있을경우_emptyParameters_에러반환() {
        let requestParameter = ParameterValidatorMockData.emptyParameters
        
        let expectation = XCTestExpectation(description: "Empty parameters should fail")
        
        RequestDataValidator.validateWithParameters(requestParameter, mockURL)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .emptyParameters)
                    expectation.fulfill()
                }
            }, receiveValue: { _, _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
