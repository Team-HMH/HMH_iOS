//
//  URLEncodingTest.swift
//  NetworksTests
//
//  Created by 류희재 on 11/11/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Core
import Networks

extension ParameterEncodingTest {
    func test_URLEncoding_정상적인파라미터와URL_URLRequest반환() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameter = ParameterValidatorMockData.validParameters
        
        let expectation = XCTestExpectation(description: "정상적으로 URL인코딩에 성공했습니다!")
        
        for parameter in requestParameter {
            validateEncoding(
                encoder: URLEncoding(),
                requestData: requestData,
                requestParameter: parameter.parameters,
                expectation: expectation
            ) { validRequest in
                guard let url = validRequest.url,
                      let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                      let queryItems = components.queryItems else {
                    XCTFail("Invalid URL or missing query parameters")
                    return
                }
                
                let sortedQueryItems = queryItems.sorted(by: { $0.name < $1.name })
                let sortedExpectedQueryItems = parameter.expectedQueryItems.sorted(by: { $0.name < $1.name })
                
                XCTAssertEqual(sortedQueryItems, sortedExpectedQueryItems)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0 * Double(requestParameter.count))
    }
    
    func test_URLEncoding_파라미터가Nil일때_invalidParametersType_에러반환() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameter = ParameterValidatorMockData.nilParameters
        
        let expectation = XCTestExpectation(description: "파라미터가 Nil이어서 실패했습니다!")
        let expectationError: HMHNetworkError.ParameterEncodingError = .invalidParametersType
        
        validateEncoding(
            encoder: URLEncoding(),
            requestData: requestData,
            requestParameter: requestParameter,
            expectation: expectation,
            expectationError: expectationError
        )
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_URLEncoding_URL이Nil일때_missingURL_에러반환() {
        let requestData = URLRequestMockData.nilURLRequest
        let requestParameter = ParameterValidatorMockData.validParameter
        
        let expectation = XCTestExpectation(description: "URL이 Nil이어서 실패했습니다!")
        let expectationError: HMHNetworkError.ParameterEncodingError = .missingURL
        
        validateEncoding(
            encoder: URLEncoding(),
            requestData: requestData,
            requestParameter: requestParameter,
            expectation: expectation,
            expectationError: expectationError
        )
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_URLEncoding_파라미터와URL둘다Nil일때_invalidParametersType_에러반환() {
        let requestData = URLRequestMockData.nilURLRequest
        let requestParameter = ParameterValidatorMockData.nilParameters
        
        let expectation = XCTestExpectation(description: "URL과 파라미터가 둘다 Nil이어서 (파라미터 먼저 처리) 실패했습니다!")
        let expectationError: HMHNetworkError.ParameterEncodingError = .invalidParametersType
        
        validateEncoding(
            encoder: URLEncoding(),
            requestData: requestData,
            requestParameter: requestParameter,
            expectation: expectation,
            expectationError: expectationError
        )
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_파라미터가비어있을경우_emptyParameters_에러반환() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameter = ParameterValidatorMockData.emptyParameters
        
        let expectation = XCTestExpectation(description: "파라미터가 비어있어서 실패했습니다!")
        let expectationError: HMHNetworkError.ParameterEncodingError = .emptyParameters
        
        validateEncoding(
            encoder: URLEncoding(),
            requestData: requestData,
            requestParameter: requestParameter,
            expectation: expectation,
            expectationError: expectationError
        )
        
        wait(for: [expectation], timeout: 1.0)
    }
}
