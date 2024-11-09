//
//  RequestValidatorTest.swift
//  NetworksTests
//
//  Created by 류희재 on 11/10/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Core
import Networks


class RequestDataValidatorTests: XCTestCase {
    
    var cancelBag: CancelBag!
    
    override func setUpWithError() throws {
        cancelBag = CancelBag()
    }
    
    override func tearDown() {
        cancelBag = nil
    }
}

/// validateWithParameters
extension RequestDataValidatorTests {
    func test_validateWithParameters_정상적인파라미터와URL일때_정상적인변환() {
        let requestData = ParameterValidatorMockData.validRequestData
        
        let expectation = XCTestExpectation(description: "유효한 파라미터와 URL입니다")
        
        RequestDataValidator.validateWithParameters(requestData.parameters, requestData.url)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but got error: \(error)")
                }
            }, receiveValue: { resultParameters, resultURL in
                XCTAssertEqual(resultParameters["username"] as? String, "류희재")
                XCTAssertEqual(resultURL.absoluteString, "https://example.com")
                expectation.fulfill()
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_validateWithParameters_파라미터가Nil일때_emptyParameters_에러반환() {
        let requestData = ParameterValidatorMockData.nilParameters
        
        let expectation = XCTestExpectation(description: "Nil parameters should fail")
        
        RequestDataValidator.validateWithParameters(requestData.parameters, requestData.url)
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
        let requestData = ParameterValidatorMockData.nilRequestURL
        
        let expectation = XCTestExpectation(description: "Nil URL should fail")
        
        RequestDataValidator.validateWithParameters(requestData.parameters, requestData.url)
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
        let requestData = ParameterValidatorMockData.nilRequestData
        
        let expectation = XCTestExpectation(description: "Nil URL should fail")
        
        RequestDataValidator.validateWithParameters(requestData.parameters, requestData.url)
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
        let requestData = ParameterValidatorMockData.emptyRequestData
        
        let expectation = XCTestExpectation(description: "Empty parameters should fail")
        
        RequestDataValidator.validateWithParameters(requestData.parameters, requestData.url)
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

/// validateWithParameters
extension RequestDataValidatorTests {
    func test_validateWithEncodable_정상적인파라미터와URL일때_정상적인변환() {
        let requestData = EncodableValidatorMockData.validEncodableData
        
        let expectation = XCTestExpectation(description: "유효한 파라미터와 URL입니다")
        
        RequestDataValidator.validateWithEncodable(requestData.parameters, requestData.url)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but got error: \(error)")
                }
            }, receiveValue: { resultParameters, resultURL in
                // 정상적인 값이 반환되는지 체크
                if let simpleData = resultParameters as? SimpleData {
                    XCTAssertEqual(simpleData.name, "John") // "John"이 반환되는지 확인
                }
                XCTAssertEqual(resultURL.absoluteString, "https://example.com") // URL이 맞는지 확인
                expectation.fulfill() // 테스트 완료 시점 알림
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_validateWithEncodable_파라미터가Nil일때_emptyParameters_에러반환() {
        let requestData = EncodableValidatorMockData.nilParameters
        
        let expectation = XCTestExpectation(description: "Nil parameters should fail")
        
        RequestDataValidator.validateWithEncodable(requestData.parameters, requestData.url)
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
    
    func test_validateWithEncodable_URL이Nil일때_missingURL_에러반환() {
        let requestData = EncodableValidatorMockData.nilRequestURL
        
        let expectation = XCTestExpectation(description: "Nil URL should fail")
        
        RequestDataValidator.validateWithEncodable(requestData.parameters, requestData.url)
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
    
    func test_validateWithEncodable_파라미터와URL둘다Nil일때_emptyParameters_에러반환() {
        let requestData = EncodableValidatorMockData.nilRequestData
        
        let expectation = XCTestExpectation(description: "Nil URL should fail")
        
        RequestDataValidator.validateWithEncodable(requestData.parameters, requestData.url)
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
}
