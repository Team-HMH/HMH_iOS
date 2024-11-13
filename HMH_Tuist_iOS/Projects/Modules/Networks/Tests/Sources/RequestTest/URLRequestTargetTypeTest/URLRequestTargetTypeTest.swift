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
        let parameterCases: [(parameters: [String: Any], expectedQueryItems: [URLQueryItem])] = [
            // 단순 키-값 쌍
            (parameters: ["key1": "value1", "key2": "value2"],
             expectedQueryItems: [URLQueryItem(name: "key1", value: "value1"),
                                  URLQueryItem(name: "key2", value: "value2")]),
            
            // 특수 문자 포함
            (parameters: ["specialChars": "!@#$%^&*()"],
             expectedQueryItems: [URLQueryItem(name: "specialChars", value: "!@#$%^&*()")]),
            
            // 공백 포함
            (parameters: ["space": "a value with spaces"],
             expectedQueryItems: [URLQueryItem(name: "space", value: "a value with spaces")]),
            
            // 다국어 (한국어)
            (parameters: ["korean": "한글"],
             expectedQueryItems: [URLQueryItem(name: "korean", value: "한글")]),
            
            // 숫자 포함
            (parameters: ["integer": 123, "float": 45.67],
             expectedQueryItems: [URLQueryItem(name: "integer", value: "123"),
                                  URLQueryItem(name: "float", value: "45.67")]),
            
            // Boolean 값 포함
            (parameters: ["isTrue": true, "isFalse": false],
             expectedQueryItems: [URLQueryItem(name: "isTrue", value: "true"),
                                  URLQueryItem(name: "isFalse", value: "false")]),
            
            // 빈 값
            (parameters: ["empty": ""],
             expectedQueryItems: [URLQueryItem(name: "empty", value: "")]),
            
            // 대소문자 구별 키
            (parameters: ["Key": "UpperCase", "key": "LowerCase"],
             expectedQueryItems: [URLQueryItem(name: "Key", value: "UpperCase"),
                                  URLQueryItem(name: "key", value: "LowerCase")]),
            
            // JSON-like 객체 (기대되는 형식으로 변환 시)
            (parameters: ["json": "{\"name\":\"test\",\"age\":30}"],
             expectedQueryItems: [URLQueryItem(name: "json", value: "{\"name\":\"test\",\"age\":30}")])
        ]
        
        for caseData in parameterCases {
            let target: URLRequestTargetType = MockRequest(
                url: self.baseURL,
                path: self.path,
                method: .get,
                headers: nil,
                task: .requestParameters(caseData.parameters),
                isWithInterceptor: true
            )
            
            let expectation = XCTestExpectation(description: "Query parameters encoded correctly for \(caseData.parameters)")
            
            target.asURLRequest()
                .sink(receiveCompletion: { completion in
                    if case .failure = completion {
                        XCTFail("Expected success but got failure \(completion)")
                    }
                }, receiveValue: { request in
                    // URLComponents로 쿼리 파라미터 분석
                    guard let url = request.url,
                          let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                          let queryItems = components.queryItems else {
                        XCTFail("Invalid URL or missing query parameters")
                        return
                    }
                    
                    let sortedQueryItems = queryItems.sorted(by: { $0.name < $1.name })
                    let sortedExpectedQueryItems = caseData.expectedQueryItems.sorted(by: { $0.name < $1.name })
                    
                    XCTAssertEqual(sortedQueryItems, sortedExpectedQueryItems)
                    expectation.fulfill()
                })
                .store(in: cancelBag)
        }
    }
    
    func test_asURLRequest_다양한JSONEncodingParameters_바디비교() {
        let parameterCases: [(parameters: Encodable, expectedJSON: [String: Any])] = [
            // 단순 키-값 쌍
            (parameters: ["key1": "value1", "key2": "value2"],
             expectedJSON: ["key1": "value1", "key2": "value2"]),
            
            // 특수 문자 포함
            (parameters: ["specialChars": "!@#$%^&*()"],
             expectedJSON: ["specialChars": "!@#$%^&*()"]),
            
            // 공백 포함
            (parameters: ["space": "a value with spaces"],
             expectedJSON: ["space": "a value with spaces"]),
            
            // 다국어 (한국어)
            (parameters: ["korean": "한글"],
             expectedJSON: ["korean": "한글"]),
            
            // 숫자 포함
            (parameters: ["integer": 123, "float": 45.67],
             expectedJSON: ["integer": 123, "float": 45.67]),
            
            // Boolean 값 포함
            (parameters: ["isTrue": true, "isFalse": false],
             expectedJSON: ["isTrue": true, "isFalse": false]),
            
            // 빈 값
            (parameters: ["empty": ""],
             expectedJSON: ["empty": ""]),
            
            // 대소문자 구별 키
            (parameters: ["Key": "UpperCase", "key": "LowerCase"],
             expectedJSON: ["Key": "UpperCase", "key": "LowerCase"]),
            
            // JSON-like 객체
//            (parameters: ["json": ["name": "test", "age": 30]],
//             expectedJSON: ["json": ["name": "test", "age": 30]])
        ]
        
        for caseData in parameterCases {
            let target: URLRequestTargetType = MockRequest(
                url: self.baseURL,
                path: self.path,
                method: .post,
                headers: ["Content-Type": "application/json"],
                task: .requestJSONEncodable(caseData.parameters),
                isWithInterceptor: true
            )
            
            let expectation = XCTestExpectation(description: "JSON body encoded correctly for \(caseData.parameters)")
            
            target.asURLRequest()
                .sink(receiveCompletion: { completion in
                    if case .failure = completion {
                        XCTFail("Expected success but got failure \(completion)")
                    }
                }, receiveValue: { request in
                    // HTTP 바디가 nil이 아닌지 확인
                    guard let httpBody = request.httpBody else {
                        XCTFail("HTTP body is nil")
                        return
                    }
                    
                    // JSON 바디를 Dictionary로 변환하여 비교
                    do {
                        let httpBodyJSON = try JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: Any]
                        XCTAssertEqual(httpBodyJSON as NSDictionary?, caseData.expectedJSON as NSDictionary)
                    } catch {
                        XCTFail("Failed to decode HTTP body to JSON: \(error)")
                    }
                    
                    expectation.fulfill()
                })
                .store(in: cancelBag)
        }
    }
}
