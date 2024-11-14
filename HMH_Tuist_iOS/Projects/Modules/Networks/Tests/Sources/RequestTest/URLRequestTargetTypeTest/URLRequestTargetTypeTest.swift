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
    let baseURL = "https://example.com"
    let method: HTTPMethod = .get
    let path = "test"
    let headers = ["Authorization": "Bearer token"]
    
    override func setUpWithError() throws {
        cancelBag = CancelBag()
        
    }
    
    override func tearDown() {
        cancelBag = nil
    }
    
    func test_asURLRequest_유효한URL이주어질때_정상적인변환() {
        let successCases: [(url: String, path: String?, expectedURL: String)] = [
            (url: "http://example.com", path: "validPath", expectedURL: "http://example.com/validPath"),
            (url: "https://example.com", path: "api/v1", expectedURL: "https://example.com/api/v1")
        ]
        for caseData in successCases {
            let target: URLRequestTargetType = MockRequest(
                url: caseData.url,
                path: caseData.path,
                method: method,
                headers: headers,
                task: .requestPlain,
                isWithInterceptor: true
            )
            
            let expectation = XCTestExpectation(description: "Success case for \(caseData.expectedURL)")
            
            target.asURLRequest()
                .sink(receiveCompletion: { completion in
                    if case .failure = completion {
                        XCTFail("Expected success but got failure \(completion)")
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
    
    func test_asURLRequest_유효하지않은URL이주어질때_에러변환() {
        let failureCases: [(url: String, path: String?, error: HMHNetworkError.RequestError)] = [
            (url: "", path: nil, error: .invalidURL("", .emptyurlString)),
            (url: "www.example.com", path: nil, error: .invalidURL("www.example.com", .invalidProtocol)),
            (url: "htp://example.com", path: nil, error: .invalidURL("htp://example.com", .invalidProtocol)),
            (url: "https://example.com:99999", path: nil, error: .invalidURL("https://example.com:99999", .invalidPort)),
            (url: "http://example.com", path: "path|with|pipes", error: .invalidURL("http://example.com/path|with|pipes", .invalidPath)),
            (url: "http://example.com", path: "path with spaces", error: .invalidURL("http://example.com/path with spaces", .invalidPath)),
            (url: "http://example.com", path: "/double/slash", error: .invalidURL("http://example.com//double/slash", .invalidPath)),
            (url: "http://example.com", path: "path#section", error: .invalidURL("http://example.com/path#section", .invalidPath)),
            (url: "http://example.com", path: "api?keyvalue", error: .invalidURL("http://example.com/api?keyvalue", .invalidQueryParameter)),
            (url: "http://example.com", path: "api?key=value&&another=value", error: .invalidURL("http://example.com/api?key=value&&another=value", .invalidQueryParameter))
        ]
        
        for caseData in failureCases {
            let target: URLRequestTargetType = MockRequest(
                url: caseData.url,
                path: caseData.path,
                method: method,
                headers: headers,
                task: .requestPlain,
                isWithInterceptor: true
            )
            
            let expectation = XCTestExpectation(description: "Failure case for \(caseData.url)")
            
            target.asURLRequest()
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTAssertEqual(error, caseData.error)
                        expectation.fulfill()
                    }
                }, receiveValue: { request in
                    XCTFail("Expected failure, but got success for URL: \(caseData.url)")
                })
                .store(in: cancelBag)
        }
    }
    
    func test_asURLRequest_다양한QueryParameters_정렬된파라미터비교() {
        let parameterCases = ParameterValidatorMockData.validParameters
        
        for caseData in parameterCases {
            let target: URLRequestTargetType = MockRequest(
                url: self.baseURL,
                path: self.path,
                method: method,
                headers: headers,
                task: .requestParameters(caseData.parameters),
                isWithInterceptor: true
            )
            
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
            let target: URLRequestTargetType = MockRequest(
                url: self.baseURL,
                path: self.path,
                method: .post,
                headers: headers,
                task: .requestJSONEncodable(caseData),
                isWithInterceptor: true
            )
            
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
