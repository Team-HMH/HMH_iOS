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


class JSONEncodingTest: XCTestCase {
    
    var cancelBag: CancelBag!
    var sut: ParameterEncoding!
    
    override func setUpWithError() throws {
        sut = JSONEncoding()
        cancelBag = CancelBag()
        
    }
    
    override func tearDown() {
        sut = nil
        cancelBag = nil
    }
    
    func validateJSONEncoding(
        encoder: ParameterEncoding,
        requestData: URLRequest,
        requestParameter: Any?,
        expectation: XCTestExpectation,
        expectationError: HMHNetworkError.ParameterEncodingError? = nil,
        validationBlock: @escaping ((URLRequest) -> Void) = { _  in})
    {
        encoder.encode(requestData, with: requestParameter)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, expectationError)
                    expectation.fulfill()
                } else {
                    if case .failure(let error) = completion {
                        XCTFail("Expected success, but got error: \(error)")
                    }
                }
            }, receiveValue: validationBlock)
            .store(in: self.cancelBag)
    }
}

extension JSONEncodingTest {
    func test_정상적인파라미터와URL_URLRequest반환() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameter = EncodableParameterMockData.validtestDatas
        
        let expectation = XCTestExpectation(description: "정상적으로 JSON 인코딩에 성공했습니다!")
        
        for parameter in requestParameter {
            validateJSONEncoding(
                encoder: sut,
                requestData: requestData,
                requestParameter: parameter,
                expectation: expectation
            ) { validRequest in
                do {
                    let expectedData = try JSONEncoder().encode(parameter)
                    XCTAssertEqual(validRequest.httpBody, expectedData, "파라미터가 예상 결과와 일치하지 않습니다.")
                    expectation.fulfill()
                } catch {
                    XCTFail("파라미터를 JSON으로 인코딩하지 못했습니다: \(error)")
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 1.0 * Double(requestParameter.count))
    }
    
    func test_파라미터가Nil일때_invalidJSON_에러반환() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameter = EncodableParameterMockData.nilParameters
        
        let expectation = XCTestExpectation(description: "파라미터가 Nil이어서 실패했습니다!")
        let expectationError: HMHNetworkError.ParameterEncodingError = .invalidJSON
        
        validateJSONEncoding(
            encoder: sut,
            requestData: requestData,
            requestParameter: requestParameter,
            expectation: expectation,
            expectationError: expectationError
        )
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_URL이Nil일때_missingURL_에러반환() {
        let requestData = URLRequestMockData.nilURLRequest
        let requestParameter = EncodableParameterMockData.validEncodableParameter
        
        let expectation = XCTestExpectation(description: "URL이 Nil이어서 실패했습니다!")
        let expectationError: HMHNetworkError.ParameterEncodingError = .missingURL
        
        validateJSONEncoding(
            encoder: sut,
            requestData: requestData,
            requestParameter: requestParameter,
            expectation: expectation,
            expectationError: expectationError
        )
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_파라미터와URL둘다Nil일때_invalidJSON_에러반환() {
        let requestData = URLRequestMockData.nilURLRequest
        let requestParameter = EncodableParameterMockData.nilParameters
        
        let expectation = XCTestExpectation(description: "URL과 파라미터가 둘다 Nil이어서 (파라미터 먼저 처리) 실패했습니다!")
        let expectationError: HMHNetworkError.ParameterEncodingError = .invalidJSON
        
        validateJSONEncoding(
            encoder: sut,
            requestData: requestData,
            requestParameter: requestParameter,
            expectation: expectation,
            expectationError: expectationError
        )
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_Encodable타입이아닐때_invalidJSON반환() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameter = EncodableParameterMockData.nonEncodableParameter
        
        let expectation = XCTestExpectation(description: "Encodable타입의 객체가 아니어서 실패했습니다!")
        let expectationError: HMHNetworkError.ParameterEncodingError = .invalidJSON
        
        validateJSONEncoding(
            encoder: sut,
            requestData: requestData,
            requestParameter: requestParameter,
            expectation: expectation,
            expectationError: expectationError
        )
        
        wait(for: [expectation], timeout: 1.0)
    }
}
