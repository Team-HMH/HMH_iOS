//
//  TaskTest.swift
//  NetworksTests
//
//  Created by 류희재 on 11/12/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Core
import Networks

class TaskTest: XCTestCase {
    
    var cancelBag: CancelBag!
    let baseURL = URL(string: "https://example.com")!
    let method: HTTPMethod = .get
    let headers = ["Authorization": "Bearer token"]
    
    override func setUpWithError() throws {
        cancelBag = CancelBag()
        
    }
    
    override func tearDown() {
        cancelBag = nil
    }
}

//requestPlain
extension TaskTest {
    func test_requestPlain일때_body없이정상적인반환() {
        let task = Task.requestPlain
        let expectation = XCTestExpectation(description: "Plain request should succeed")
        
        task.buildRequest(baseURL: baseURL, method: method, headers: headers)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success, got failure")
                }
                expectation.fulfill()
            }, receiveValue: { request in
                XCTAssertEqual(request.url, self.baseURL)
                XCTAssertEqual(request.httpMethod, "GET")
                XCTAssertEqual(request.allHTTPHeaderFields, self.headers)
                XCTAssertNil(request.httpBody, "Request body should be nil for plain request")
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
}

//requestParameters
extension TaskTest {
    func test_requestParameters_정상적인파라미터일때_body없이정상적인반환() {
        let task = Task.requestParameters(ParameterValidatorMockData.validParameter)
        let expectation = XCTestExpectation(description: "정상적인 바디일때 성공")
        
        task.buildRequest(baseURL: baseURL, method: method, headers: headers)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success, got failure")
                }
                expectation.fulfill()
            }, receiveValue: { encodedRequest in
                if let url = encodedRequest.url?.absoluteString {
                    XCTAssertEqual(encodedRequest.url, self.baseURL)
                    XCTAssertTrue(url.contains("age=25"))
                    XCTAssertTrue(url.contains("username=hellohidi"))
                    XCTAssertEqual(encodedRequest.httpMethod, "GET")
                    XCTAssertEqual(encodedRequest.allHTTPHeaderFields, self.headers)
                    XCTAssertNil(encodedRequest.httpBody, "Request body should be nil for URL encoded parameters")
                }
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_requestParameters_파라미터가비어있을때_emptyParameter반환() {
        let task = Task.requestParameters(ParameterValidatorMockData.emptyParameters)
        let expectation = XCTestExpectation(description: "파라미터가비어있을때 실패")
        
        task.buildRequest(baseURL: baseURL, method: method, headers: headers)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .parameterEncodingFailed(.emptyParameters))
                    expectation.fulfill()
                }
            }, receiveValue: { request in
                XCTFail("Expected failure, but got success")
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_requestParameters_특수문자가있을때_정상적인반환() {
        let task = Task.requestParameters(ParameterValidatorMockData.unicodeCharacters)
        let expectation = XCTestExpectation(description: "파라미터가비어있을때 실패")
        
        task.buildRequest(baseURL: baseURL, method: method, headers: headers)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Encoding should succeed with special characters in parameters")
                }
            }, receiveValue: { encodedRequest in
                if let url = encodedRequest.url?.absoluteString {
                    XCTAssertEqual(encodedRequest.httpMethod, "GET")
                    XCTAssertEqual(encodedRequest.allHTTPHeaderFields, self.headers)
                    XCTAssertTrue(url.contains("greeting=%EC%95%88%EB%85%95%ED%95%98%EC%84%B8%EC%9A%94"))
                    XCTAssertTrue(url.contains("emoji=%F0%9F%99%82%F0%9F%9A%80"))
                    XCTAssertNil(encodedRequest.httpBody, "Request body should be nil for URL encoded parameters")
                }
                expectation.fulfill()
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
}

extension TaskTest {
    func test_requestJSONEncodable_정상적인파라미터일때_정상적인반환() {
        let validTestData = EncodableParameterMockData.validtestData
        let expectation = XCTestExpectation(description: "여러 타입의 정상적인 파라미터 테스트")
        expectation.expectedFulfillmentCount = validTestData.count  // 여러 개의 요청을 기다리기 위해 설정
        
        for (parameter, description) in validTestData {
            let task = Task.requestJSONEncodable(parameter)
            
            task.buildRequest(baseURL: baseURL, method: method, headers: headers)
                .sink(receiveCompletion: { completion in
                    if case .failure = completion {
                        XCTFail("\(description): Expected success, got failure")
                    }
                }, receiveValue: { encodedRequest in
                    XCTAssertEqual(encodedRequest.url, self.baseURL)
                    XCTAssertEqual(encodedRequest.httpMethod, "GET")
                    XCTAssertEqual(encodedRequest.allHTTPHeaderFields, self.headers)
                    
                    if let body = encodedRequest.httpBody {
                        do {
                            let expectedBody = try JSONEncoder().encode(parameter)
                            XCTAssertEqual(body, expectedBody, "\(description): Encoded JSON does not match expected JSON")
                        } catch {
                            XCTFail("\(description): Failed to encode expected JSON")
                        }
                    } else {
                        XCTFail("\(description): Request body is nil")
                    }
                    expectation.fulfill()
                })
                .store(in: cancelBag)
        }
        
        wait(for: [expectation], timeout: 1.0 * Double(validTestData.count))
    }
}
