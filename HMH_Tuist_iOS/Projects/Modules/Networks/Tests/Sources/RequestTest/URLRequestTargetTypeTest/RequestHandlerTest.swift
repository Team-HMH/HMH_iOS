//
//  RequestHandlerTest.swift
//  NetworksTests
//
//  Created by 류희재 on 11/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Networks
import Core

class RequestHandlerTests: XCTestCase {
    var cancelBag: CancelBag!
    let url = "https://example.com"
    let method: HTTPMethod = .get
    let headers = ["Authorization": "Bearer token"]
    
    override func setUp() {
        super.setUp()
        cancelBag = CancelBag()
    }
    
    override func tearDown() {
        cancelBag = nil
        super.tearDown()
    }
}

extension RequestHandlerTests {
    func test_다양한URL케이스가주어질때_적절히변환() {
        let testCases = URLValidatorMockData.urlTargetTypeMockData
        let expectation = XCTestExpectation(description: "해당 URL에 대한 결과를 적절히 변환하였습니다!")
        
        for caseData in testCases {
            let target = RequestTestHandler.makeMockRequest(url: caseData.url, path: caseData.path)
            
            RequestHandler.createURLRequest(for: target)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTAssertEqual(error, .invalidRequest(caseData.error!))
                        expectation.fulfill()
                    } else {
                        if case .failure(let error) = completion {
                            XCTFail("Expected success, but got error: \(error)")
                            expectation.fulfill()
                        }
                    }
                }, receiveValue: { validRequest in
                    XCTAssertEqual(validRequest.url?.absoluteString, caseData.expectedURL)
                    XCTAssertEqual(validRequest.httpMethod, self.method.rawValue)
                    XCTAssertEqual(validRequest.allHTTPHeaderFields, self.headers)
                    expectation.fulfill()
                })
                .store(in: cancelBag)
        }
    }
    
    func test_다양한QueryParameters_정렬된파라미터비교() {
        let testCases = ParameterValidatorMockData.validParameters
        
        for caseData in testCases {
            let target = RequestTestHandler.makeMockRequest(task: .requestParameters(caseData.parameters))
            
            let expectation = XCTestExpectation(description: "Query parameters encoded correctly for \(caseData.parameters)")
            
            RequestHandler.createURLRequest(for: target)
                .sink(receiveCompletion: { completion in
                    if case .failure = completion {
                        XCTFail("Expected failed: \(completion)")
                    }
                }, receiveValue: { validRequest in
                    XCTAssertEqual(validRequest.httpMethod, self.method.rawValue)
                    XCTAssertEqual(validRequest.allHTTPHeaderFields, self.headers)
                    RequestTestHandler.checkValidQuaryItem(
                        expectation: expectation,
                        validRequest: validRequest,
                        expectedQueryItems: caseData.expectedQueryItems
                    )
                    expectation.fulfill()
                })
                .store(in: cancelBag)
        }
    }
    
    func test_다양한JSONEncodingParameters_바디비교() {
        let testCases = EncodableParameterMockData.validParameters
        
        for caseData in testCases {
            let target = RequestTestHandler.makeMockRequest(task: .requestJSONEncodable(caseData))
            
            let expectation = XCTestExpectation(description: "JSON body encoded correctly for \(caseData)")
            
            RequestHandler.createURLRequest(for: target)
                .sink(receiveCompletion: { completion in
                    if case .failure = completion {
                        XCTFail("Expected failed: \(completion)")
                    }
                }, receiveValue: { validRequest in
                    XCTAssertEqual(validRequest.url?.absoluteString, self.url)
                    XCTAssertEqual(validRequest.httpMethod, self.method.rawValue)
                    XCTAssertEqual(validRequest.allHTTPHeaderFields, self.headers)
                    RequestTestHandler.checkValidHTTPBody(
                        expectation: expectation,
                        validRequest: validRequest,
                        expectedParameter: caseData
                    )
                    
                    expectation.fulfill()
                })
                .store(in: cancelBag)
        }
    }
}
