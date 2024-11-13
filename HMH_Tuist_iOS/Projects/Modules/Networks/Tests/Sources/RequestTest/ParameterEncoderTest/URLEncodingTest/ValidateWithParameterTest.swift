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
        let requestParameter = ParameterValidatorMockData.validParameters
        let expectation = XCTestExpectation(description: "유효한 파라미터와 URL입니다!")
        let expectedError: HMHNetworkError.ParameterEncodingError = .emptyParameters
        
        for parameter in requestParameter {
            validateWithParameters(
                parameters: parameter,
                url: mockURL,
                expectedError: expectedError,
                expectation: expectation
            ) { validParameters, validURL in
                // 각 케이스에 맞는 검증 수행
                for (key, expectedValue) in parameter {
                    // 실제 값과 기대값을 비교
                    XCTAssertEqual(validParameters[key] as? String, expectedValue as? String, "키: \(key) 값이 일치하지 않습니다.")
                }
                XCTAssertEqual(validURL, self.mockURL)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0 * Double(requestParameter.count))
    }
    
    func test_validateWithParameters_파라미터가Nil일때_emptyParameters_에러반환() {
        let requestParameter = ParameterValidatorMockData.nilParameters
        let expectation = XCTestExpectation(description: "파라미터가 Nil이어서 실패했습니다!")
        let expectedError: HMHNetworkError.ParameterEncodingError = .emptyParameters
        
        validateWithParameters(
            parameters: requestParameter,
            url: mockURL,
            expectedError: expectedError,
            expectation: expectation
        )
    }
    
    func test_validateWithParameters_URL이Nil일때_missingURL_에러반환() {
        let requestParameter = ParameterValidatorMockData.validParameter
        let expectation = XCTestExpectation(description: "URL이 Nil이어서 실패했습니다!")
        let expectedError: HMHNetworkError.ParameterEncodingError = .missingURL
        
        validateWithParameters(
            parameters: requestParameter,
            url: nil,
            expectedError: expectedError,
            expectation: expectation
        )
        
        wait(for: [expectation], timeout: 1.0)
        
    }
    
    func test_validateWithParameters_파라미터와URL둘다Nil일때_missingURL_에러반환() {
        let requestParameter = ParameterValidatorMockData.nilParameters
        let expectation = XCTestExpectation(description: "URL과 파라미터가 둘다 Nil이어서 (url 먼저 처리) 실패했습니다!")
        let expectedError: HMHNetworkError.ParameterEncodingError = .missingURL
        
        validateWithParameters(
            parameters: requestParameter,
            url: nil,
            expectedError: expectedError,
            expectation: expectation
        )
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_validateWithParameters_파라미터가비어있을경우_emptyParameters_에러반환() {
        let requestParameter = ParameterValidatorMockData.emptyParameters
        let expectation = XCTestExpectation(description: "파라미터가 비어있어서 실패했습니다!")
        let expectedError: HMHNetworkError.ParameterEncodingError = .emptyParameters
        
        validateWithParameters(
            parameters: requestParameter,
            url: mockURL,
            expectedError: expectedError,
            expectation: expectation
        )
        
        wait(for: [expectation], timeout: 1.0)
    }
}
