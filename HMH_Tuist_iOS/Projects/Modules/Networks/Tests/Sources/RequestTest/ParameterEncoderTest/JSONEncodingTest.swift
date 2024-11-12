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
}

extension JSONEncodingTest {
    func test_정상적인파라미터와URL_URLRequest반환() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameter = EncodableParameterMockData.validtestData
        
        let expectations = requestParameter.map { parameter in
            return XCTestExpectation(description: "Encoding for \(parameter)")
        }
        
        for (index, parameter) in requestParameter.enumerated() {
            sut.encode(requestData, with: parameter.0)
                .sink(receiveCompletion: { completion in
                    if case .failure = completion {
                        XCTFail("Encoding failed for \(parameter.1)")
                    }
                    expectations[index].fulfill()
                }, receiveValue: { request in
                    XCTAssertNotNil(request.httpBody, "\(parameter) failed, body is nil")
                })
                .store(in: cancelBag)
        }
        
        wait(for: expectations, timeout: 1.0 * Double(requestParameter.count))
    }
    
    
    func test_파라미터가Nil일때_invalidJSON_에러반환() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameter = EncodableParameterMockData.nilParameters
        
        let expectation = XCTestExpectation(description: "Nil parameters should fail")
        
        sut.encode(requestData, with: requestParameter)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .invalidJSON)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_URL이Nil일때_missingURL_에러반환() {
        let requestData = URLRequestMockData.nilURLRequest
        let requestParameter = EncodableParameterMockData.validtestData
        
        let expectation = XCTestExpectation(description: "Nil parameters should fail")
        
        sut.encode(requestData, with: requestParameter)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .missingURL)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_파라미터와URL둘다Nil일때_invalidJSON_에러반환() {
        let requestData = URLRequestMockData.nilURLRequest
        let requestParameter = EncodableParameterMockData.nilParameters
        
        let expectation = XCTestExpectation(description: "Nil parameters should fail")
        
        sut.encode(requestData, with: requestParameter)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .invalidJSON)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_Encodable타입이아닐때_invalidJSON반환() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameter = EncodableParameterMockData.nonEncodableParameter
        
        let expectation = XCTestExpectation(description: "JSON 인코딩에 실패했습니다!")
        
        sut.encode(requestData, with: requestParameter)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .invalidJSON, "\(requestParameter)")
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success \(requestParameter)")
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
