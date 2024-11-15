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

// 성공했을때 명확한 httpBody가 나오는지
// jsonEncodingError가 되는 값을 주었을때 명확히 실패가 되는지

struct MockJSONEncoding: JSONEncodingType {
    public init() {}
    public var jsonEncodeResult: AnyPublisher<URLRequest, HMHNetworkError.ParameterEncodingError>!
    
    func encode(_ request: URLRequest, with parameters: Encodable) -> AnyPublisher<URLRequest, HMHNetworkError.ParameterEncodingError> {
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
        expectationError: HMHNetworkError.ParameterEncodingError? = nil,
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
    
    // 이런경우의 수가 없음
//    func test_JSONEncoding_파라미터가Nil일때_invalidJSON_에러반환() {
//        let requestData = URLRequestMockData.validRequestData
//        let requestParameter = EncodableParameterMockData.nilParameters
//        
//        let expectation = XCTestExpectation(description: "파라미터가 Nil이어서 실패했습니다!")
//        let expectationError: HMHNetworkError.ParameterEncodingError = .invalidJSON
//        
//        validateEncoding(
//            encoder: JSONEncoding(),
//            requestData: requestData,
//            requestParameter: requestParameter,
//            expectation: expectation,
//            expectationError: expectationError
//        )
//        
//        wait(for: [expectation], timeout: 1.0)
//    }
    
    // 이런경우의 수가 없음
//    func test_JSONEncoding_URL이Nil일때_missingURL_에러반환() {
//        let requestData = URLRequestMockData.nilURLRequest
//        let requestParameter = EncodableParameterMockData.validEncodableParameter
//        
//        let expectation = XCTestExpectation(description: "URL이 Nil이어서 실패했습니다!")
//        let expectationError: HMHNetworkError.ParameterEncodingError = .missingURL
//        
//        validateEncoding(
//            encoder: JSONEncoding(),
//            requestData: requestData,
//            requestParameter: requestParameter,
//            expectation: expectation,
//            expectationError: expectationError
//        )
//        
//        wait(for: [expectation], timeout: 1.0)
//    }
    
    // 이런경우의 수가 없음
//    func test_JSONEncoding_파라미터와URL둘다Nil일때_invalidJSON_에러반환() {
//        let requestData = URLRequestMockData.nilURLRequest
//        let requestParameter = EncodableParameterMockData.nilParameters
//        
//        let expectation = XCTestExpectation(description: "URL과 파라미터가 둘다 Nil이어서 (파라미터 먼저 처리) 실패했습니다!")
//        let expectationError: HMHNetworkError.ParameterEncodingError = .invalidJSON
//        
//        validateEncoding(
//            encoder: JSONEncoding(),
//            requestData: requestData,
//            requestParameter: requestParameter,
//            expectation: expectation,
//            expectationError: expectationError
//        )
//        
//        wait(for: [expectation], timeout: 1.0)
//    }
    
    // 이런경우의 수가 없음
    
//    func test_JSONEncoding_Encodable타입이아닐때_invalidJSON반환() {
//        let requestData = URLRequestMockData.validRequestData
//        let requestParameter = EncodableParameterMockData.nonEncodableParameter
//        
//        let expectation = XCTestExpectation(description: "Encodable타입의 객체가 아니어서 실패했습니다!")
//        let expectationError: HMHNetworkError.ParameterEncodingError = .invalidJSON
//        
//        validateEncoding(
//            encoder: JSONEncoding(),
//            requestData: requestData,
//            requestParameter: requestParameter,
//            expectation: expectation,
//            expectationError: expectationError
//        )
//        
//        wait(for: [expectation], timeout: 1.0)
//    }

