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
    func test_asURLRequest_다양한케이스URL이주어질때_적절히변환() {
        let urlCases = URLValidatorMockData.urlTargetTypeMockData
        for caseData in urlCases {
            let target = RequestTestHandler.makeMockRequest(url: caseData.url, path: caseData.path)
            let expectation = XCTestExpectation(description: "해당 URL에 대한 결과를 적절히 변환하였습니다!")
            
            let expectationError: HMHNetworkError.RequestError? = caseData.error != nil ?
                .invalidURL(caseData.error!) : nil
            
            target.asURLRequest()
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        XCTAssertEqual(error, expectationError, "Expected success, but got error: \(error)")
                        expectation.fulfill()
                    case .finished:
                        if caseData.error != nil {
                            XCTFail("Expected error \(String(describing: caseData.error)), but received success.")
                        }
                        expectation.fulfill()
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
            let target = RequestTestHandler.makeMockRequest(task: .requestParameters(caseData.parameters))
            
            let expectation = XCTestExpectation(description: "쿼리파라미터가 성공적으로 인코딩되었습니다! \(caseData.parameters)")
            
            target.asURLRequest()
                .sink(receiveCompletion: { completion in
                    if case .failure = completion {
                        XCTFail("Expected failed: \(completion)")
                    }
                }, receiveValue: { validRequest in
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
    
    func test_asURLRequest_다양한JSONEncodingParameters_바디비교() {
        let parameterCases = EncodableParameterMockData.validParameters
        
        for caseData in parameterCases {
            let target = RequestTestHandler.makeMockRequest(task: .requestJSONEncodable(caseData))
            
            let expectation = XCTestExpectation(description: "JSON body가 성공적으로 인코딩되었습니다! \(caseData)")
            
            target.asURLRequest()
                .sink(receiveCompletion: { completion in
                    if case .failure = completion {
                        XCTFail("Expected failed: \(completion)")
                    }
                }, receiveValue: { validRequest in
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

    
