//
//  ErrorHandlerTest.swift
//  NetworksTests
//
//  Created by 류희재 on 11/19/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Core
import Networks

class ErrorHandlerTest: XCTestCase {
    var cancelBag: CancelBag!
    var mockURLReqeust = URLRequestMockData.validRequestData
    var mockRequestTarget = MockURLRequestTarget.mockTargetType
    var mockParameter = EncodableParameterMockData.validEncodableParameter
    
    override func setUpWithError() throws {
        cancelBag = CancelBag()
    }
    
    override func tearDown() {
        cancelBag = nil
    }
}

extension ErrorHandlerTest {
    func test_파라미터에러가주어질때_적절한에러로변환하는가() {
        let parameterEncodingError: [HMHNetworkError.RequestError.ParameterEncodingError] = [
            .emptyParameters,
            .jsonEncodingFailed,
            .missingURL,
            .urlEncodingFailed,
            .unknownErr
        ]
        
        parameterEncodingError.forEach {
            let error = ErrorHandler.handleParameterEncodingError(mockURLReqeust, mockParameter, error: $0)
            XCTAssertEqual(error, .parameterEncodingFailed($0))
        }
    }
    
    func test_url에에러가주어질때_적절한에러로변환하는가() {
        let inValidURLError: [HMHNetworkError.RequestError.URLValidationError] = [
            .emptyurlString,
            .invalidPath,
            .invalidPort,
            .invalidProtocol,
            .invalidQueryParameter
        ]
        
        inValidURLError.forEach { invalidError in
            
            let expectation = XCTestExpectation(description: "\(invalidError)에 대한 적절한 에러를 반환합니다!")
            
            ErrorHandler.handleInvalidURLError(mockRequestTarget, error: invalidError)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        XCTAssertEqual(error, .invalidURL(invalidError), "Expected success, but got error: \(error)")
                        expectation.fulfill()
                    }
                }, receiveValue: { _ in })
                .store(in: cancelBag)
        }
    }
    
    func test_응답이오지않았을때_적절한에러로변환하는가() {
        let noResponseError: [HMHNetworkError.ResponseError] = [
            .cancelled,
            .unhandled,
            .unknown
        ]
        
        noResponseError.forEach {
            let error = ErrorHandler.handleNoResponseError(mockRequestTarget, error: $0)
            XCTAssertEqual(error, .invalidResponse($0))
        }
        
    }
    
    func test_유효하지않은응답에러가주어질때_ErrorResponse로인코딩이되는경우_적절한에러로변환하는가() {
        let mockResponse = NetworkResponseMockData.responseWith(
            statusCode: 404,
            data: NetworkResponseMockData.validErrorData
        )
        
        let error = ErrorHandler.handleInvalidResponse(response: mockResponse)
        
        if case let .invalidResponse(responseError) = error,
           case let .invalidStatusCode(code, message) = responseError {
            XCTAssertEqual(code, 404)
            XCTAssertEqual(message, "테스트를 위해서 사용된 에러메세지입니다!")
        } else {
            XCTFail("Expected invalidResponse with invalidStatusCode")
        }
    }
    
    func test_유효하지않은응답에러가주어질때_ErrorResponse로인코딩이되지않는경우_적절한에러로변환하는가() {
        let mockResponse = NetworkResponseMockData.responseWith(
            statusCode: 404,
            data: NetworkResponseMockData.invalidErrorData
        )
        
        let error = ErrorHandler.handleInvalidResponse(response: mockResponse)
        
        if case let .invalidResponse(responseError) = error,
           case let .invalidStatusCode(code, _) = responseError {
            XCTAssertEqual(code, 404)
        } else {
            XCTFail("Expected invalidResponse with invalidStatusCode")
        }
    }
    
    func test_유효하지않은응답에러가주어질때_데이터가없는경우_적절한에러로변환하는가() {
        let mockResponse = NetworkResponseMockData.responseWith(
            statusCode: 404,
            data: nil
        )
        
        let error = ErrorHandler.handleInvalidResponse(response: mockResponse)
        
        if case let .invalidResponse(responseError) = error,
           case .noResponseData = responseError {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected invalidResponse with noResponseData")
        }
    }
    
    func test_요청횟수가초과에러가주어질때_적절한에러로변환하는가() {
        let error = ErrorHandler.handleRetryLimitExceeded()
        XCTAssertEqual(error, .retryLimitExceeded)
    }
    
    func test_디코딩에러가주어질때_적절한에러로변환하는가() {
        let decodingError: [HMHNetworkError.DecodeError] = [
            .dataIsNil,
            .decodingFailed
        ]
        
        decodingError.forEach {
            let error = ErrorHandler.handleDecodingError(data: Data(), decodingType: MockResult.self, error: $0)
            XCTAssertEqual(error, .decodingFailed($0))
        }
    }
}
