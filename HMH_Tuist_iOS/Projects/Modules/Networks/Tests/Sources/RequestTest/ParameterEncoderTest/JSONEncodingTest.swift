//
//  JSONEncodingTest.swift
//  NetworksTests
//
//  Created by 류희재 on 11/11/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Core
import Networks

///JSON 인코딩
extension ParameterEncodingTest {
    func test_JSONEncoding_정상적인파라미터와URL_URLRequest반환() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameter = EncodableParameterMockData.validParameters
        
        let expectation = XCTestExpectation(description: "정상적으로 JSON 인코딩에 성공했습니다!")
        
        for parameter in requestParameter {
            validateEncoding(
                encoder: JSONEncoding(),
                requestData: requestData,
                requestParameter: parameter,
                expectation: expectation
            ) { validRequest in
                EncodingValidationHandler.checkValidHTTPBody(
                    expectation: expectation,
                    validRequest: validRequest,
                    expectedParameter: parameter
                )
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0 * Double(requestParameter.count))
    }
    
    func test_JSONEncoding_파라미터가Nil일때_invalidJSON_에러반환() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameter = EncodableParameterMockData.nilParameters
        
        let expectation = XCTestExpectation(description: "파라미터가 Nil이어서 실패했습니다!")
        let expectationError: HMHNetworkError.ParameterEncodingError = .invalidJSON
        
        validateEncoding(
            encoder: JSONEncoding(),
            requestData: requestData,
            requestParameter: requestParameter,
            expectation: expectation,
            expectationError: expectationError
        )
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_JSONEncoding_URL이Nil일때_missingURL_에러반환() {
        let requestData = URLRequestMockData.nilURLRequest
        let requestParameter = EncodableParameterMockData.validEncodableParameter
        
        let expectation = XCTestExpectation(description: "URL이 Nil이어서 실패했습니다!")
        let expectationError: HMHNetworkError.ParameterEncodingError = .missingURL
        
        validateEncoding(
            encoder: JSONEncoding(),
            requestData: requestData,
            requestParameter: requestParameter,
            expectation: expectation,
            expectationError: expectationError
        )
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_JSONEncoding_파라미터와URL둘다Nil일때_invalidJSON_에러반환() {
        let requestData = URLRequestMockData.nilURLRequest
        let requestParameter = EncodableParameterMockData.nilParameters
        
        let expectation = XCTestExpectation(description: "URL과 파라미터가 둘다 Nil이어서 (파라미터 먼저 처리) 실패했습니다!")
        let expectationError: HMHNetworkError.ParameterEncodingError = .invalidJSON
        
        validateEncoding(
            encoder: JSONEncoding(),
            requestData: requestData,
            requestParameter: requestParameter,
            expectation: expectation,
            expectationError: expectationError
        )
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_JSONEncoding_Encodable타입이아닐때_invalidJSON반환() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameter = EncodableParameterMockData.nonEncodableParameter
        
        let expectation = XCTestExpectation(description: "Encodable타입의 객체가 아니어서 실패했습니다!")
        let expectationError: HMHNetworkError.ParameterEncodingError = .invalidJSON
        
        validateEncoding(
            encoder: JSONEncoding(),
            requestData: requestData,
            requestParameter: requestParameter,
            expectation: expectation,
            expectationError: expectationError
        )
        
        wait(for: [expectation], timeout: 1.0)
    }
}
