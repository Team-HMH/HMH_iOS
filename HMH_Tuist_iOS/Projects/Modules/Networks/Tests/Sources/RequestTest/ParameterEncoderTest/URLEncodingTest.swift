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

// 성공했을때 명확한 URLQuaryItem을 반환하는지
// 빈값이 주어졌을때 emptyParamter가 나오는지
// urlEncoding의 실패했을때 urlEncodingFailed 에러를 반환하는지

class MockURLEncoding: URLEncodingType {
    public init() {}
    public var urlEncodeResult: AnyPublisher<URLRequest, HMHNetworkError.RequestError.ParameterEncodingError>!
    
    func encode(_ request: URLRequest, with parameters: Networks.Parameters) -> AnyPublisher<URLRequest, HMHNetworkError.RequestError.ParameterEncodingError> {
        return urlEncodeResult
    }
}

class URLEncodingTest: XCTestCase {
    var cancelBag: CancelBag!
    var sut: URLEncodingType!
    
    override func setUpWithError() throws {
        sut = URLEncoding()
        cancelBag = CancelBag()
        
    }
    
    override func tearDown() {
        sut = nil
        cancelBag = nil
    }
    
    func validateEncoding(
        encoder: URLEncodingType,
        requestData: URLRequest,
        requestParameter: Parameters,
        expectation: XCTestExpectation,
        expectationError: HMHNetworkError.RequestError.ParameterEncodingError? = nil,
        validationBlock: @escaping ((URLRequest) -> Void) = { _  in})
    {
        encoder.encode(requestData, with: requestParameter)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error, expectationError, "Expected success, but got error: \(error)")
                    expectation.fulfill()
                case .finished:
                    if expectationError != nil {
                        XCTFail("Expected error \(String(describing: expectationError)), but received success.")
                        expectation.fulfill()
                    }
                }
            }, receiveValue: validationBlock)
            .store(in: self.cancelBag)
    }
}



extension URLEncodingTest {
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
                RequestTestHandler.checkValidQuaryItem(
                    expectation: expectation,
                    validRequest: validRequest,
                    expectedQueryItems: parameter.expectedQueryItems
                )
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0 * Double(requestParameter.count))
    }
    
    func test_URLEncoding_URL이Nil일때_missingURL_에러반환() {
        let requestData = URLRequestMockData.nilURLRequest
        let requestParameter = ParameterValidatorMockData.validParameter
        
        let expectation = XCTestExpectation(description: "URL이 Nil이어서 실패했습니다!")
        let expectationError: HMHNetworkError.RequestError.ParameterEncodingError = .missingURL
        
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
        let expectationError: HMHNetworkError.RequestError.ParameterEncodingError = .emptyParameters
        
        validateEncoding(
            encoder: URLEncoding(),
            requestData: requestData,
            requestParameter: requestParameter,
            expectation: expectation,
            expectationError: expectationError
        )
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // 적절한 테스트 케이스가 없어서 테스트가 어려움
//    func test_비정상적인URLRequeset가주어질때_urlEncodingError에러반환() {
//        let requestData = URLRequestMockData.invalidURLRequest
//        let requestParameter = ParameterValidatorMockData.validParameter
//        
//        let expectation = XCTestExpectation(description: "urlEncodingError")
//        let expectationError: HMHNetworkError.RequestError.ParameterEncodingError = .urlEncodingFailed
//        
//        validateEncoding(
//            encoder: URLEncoding(),
//            requestData: requestData,
//            requestParameter: requestParameter,
//            expectation: expectation,
//            expectationError: expectationError
//        )
//        
//        wait(for: [expectation], timeout: 1.0)
//    }
}
