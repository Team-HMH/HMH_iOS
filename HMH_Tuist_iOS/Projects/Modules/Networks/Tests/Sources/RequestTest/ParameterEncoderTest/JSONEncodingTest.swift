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

struct MockJSONEncoding: JSONEncodingType {
    public init() {}
    public var jsonEncodeResult: AnyPublisher<URLRequest, HMHNetworkError.RequestError.ParameterEncodingError>!
    
    func encode(_ request: URLRequest, with parameters: Encodable) -> AnyPublisher<URLRequest, HMHNetworkError.RequestError.ParameterEncodingError> {
        return jsonEncodeResult
    }
}


class JsonEncodingTest: XCTestCase {
    var cancelBag: CancelBag!
    var sut: JSONEncodingType!
    
    override func setUpWithError() throws {
        sut = JSONEncoding()
        cancelBag = CancelBag()
        
    }
    
    override func tearDown() {
        sut = nil
        cancelBag = nil
    }
    
    func validateEncoding(
        encoder: JSONEncodingType,
        requestData: URLRequest,
        requestParameter: Encodable,
        expectation: XCTestExpectation,
        expectationError: HMHNetworkError.RequestError.ParameterEncodingError? = nil,
        validationBlock: @escaping ((URLRequest) -> Void) = { _  in})
    {
        encoder.encode(requestData, with: requestParameter)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error, expectationError, "Expected success, but got error: \(error)")
                case .finished:
                    if expectationError != nil {
                        XCTFail("Expected error \(String(describing: expectationError)), but received success.")
                    }
                    expectation.fulfill()
                }
            }, receiveValue: validationBlock)
            .store(in: self.cancelBag)
    }
}

///JSON 인코딩
extension JsonEncodingTest {
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
                RequestTestHandler.checkValidHTTPBody(
                    expectation: expectation,
                    validRequest: validRequest,
                    expectedParameter: parameter
                )
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0 * Double(requestParameter.count))
    }
}
