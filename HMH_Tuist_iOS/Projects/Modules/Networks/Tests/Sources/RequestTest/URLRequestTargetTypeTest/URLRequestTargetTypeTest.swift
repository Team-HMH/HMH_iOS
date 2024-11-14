//
//  URLRequestTargetTypeTest.swift
//  NetworksTests
//
//  Created by 류희재 on 11/12/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Core
import Networks

struct MockRequest: URLRequestTargetType {
    var url: String
    var path: String?
    var method: HTTPMethod
    var headers: [String : String]?
    var task: Task
    var isWithInterceptor: Bool
}

class URLRequestTargetTypeTest: XCTestCase {
    
    var cancelBag: CancelBag!
    let method: HTTPMethod = .get
    let headers = ["Authorization": "Bearer token"]
    
    override func setUpWithError() throws {
        cancelBag = CancelBag()
        
    }
    
    override func tearDown() {
        cancelBag = nil
    }
}
    
extension URLRequestTargetTypeTest {
    private func makeMockRequest(
        url: String = "https://example.com",
        path: String? = nil,
        method: HTTPMethod = .get,
        task: Task = .requestPlain
    ) -> MockRequest {
        return MockRequest(
            url: url,
            path: path,
            method: method,
            headers: headers,
            task: task,
            isWithInterceptor: true
        )
    }

    func test_asURLRequest_다양한케이스URL이주어질때_적절히변환() {
        let urlCases = URLValidatorMockData.urlTargetTypeMockData
        for caseData in urlCases {
            let target = makeMockRequest(url: caseData.url, path: caseData.path)
            let expectation = XCTestExpectation(description: "해당 URL에 대한 결과를 적절히 변환하였습니다!")
            
            target.asURLRequest()
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTAssertEqual(error, caseData.error)
                        expectation.fulfill()
                    } else {
                        if case .failure(let error) = completion {
                            XCTFail("Expected success, but got error: \(error)")
                            expectation.fulfill()
                        }
                    }
                }, receiveValue: { request in
                    XCTAssertEqual(request.url?.absoluteString, caseData.expectedURL)
                    XCTAssertEqual(request.httpMethod, self.method.rawValue)
                    XCTAssertEqual(request.allHTTPHeaderFields, self.headers)
                    expectation.fulfill()
                })
                .store(in: cancelBag)
        }
    }
    
    func test_asURLRequest_다양한QueryParameters_정렬된파라미터비교() {
        let parameterCases = ParameterValidatorMockData.validParameters
        
        for caseData in parameterCases {
            let target = makeMockRequest(task: .requestParameters(caseData.parameters))
            
            let expectation = XCTestExpectation(description: "Query parameters encoded correctly for \(caseData.parameters)")
            
            target.asURLRequest()
                .sink(receiveCompletion: { completion in
                    if case .failure = completion {
                        XCTFail("Expected success but got failure \(completion)")
                    }
                }, receiveValue: { validRequest in
                    EncodingValidationHandler.checkValidQuaryItem(
                        expectation: expectation,
                        validRequest: validRequest,
                        expectedQueryItems: caseData.expectedQueryItems
                    )
                    expectation.fulfill()
                })
                .store(in: cancelBag)
        }
    }
    
    func test_asURLRequest_다양한JSONEncodingParameters_바디비교() {
        let parameterCases = EncodableParameterMockData.validParameters
        
        for caseData in parameterCases {
            let target = makeMockRequest(task: .requestJSONEncodable(caseData))
            
            let expectation = XCTestExpectation(description: "JSON body encoded correctly for \(caseData)")
            
            target.asURLRequest()
                .sink(receiveCompletion: { completion in
                    if case .failure = completion {
                        XCTFail("Expected success but got failure \(completion)")
                    }
                }, receiveValue: { validRequest in
                    EncodingValidationHandler.checkValidHTTPBody(
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

    
