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
    
    public func asURLRequest() -> AnyPublisher<URLRequest, HMHNetworkError.RequestError> {
        var finalURL = self.url
        
        //        if let path = self.path {
        //            finalURL = finalURL.trimmingCharacters(in: .whitespacesAndNewlines) + "/" + path.trimmingCharacters(in: .whitespacesAndNewlines)
        //        }
        
        switch URLValidator.validateURL(finalURL) {
        case .failure(let validationError):
            return Fail(error: .invalidURL(finalURL, validationError)).eraseToAnyPublisher()
            
        case .success(let validURL):
            return task.buildRequest(baseURL: validURL, method: self.method, headers: self.headers)
        }
    }
}

class URLRequestTargetTypeTest: XCTestCase {
    
    var cancelBag: CancelBag!
    let baseURL = "https://example.com"
    let method: HTTPMethod = .get
    let path = "/test"
    let headers = ["Authorization": "Bearer token"]
    
    override func setUpWithError() throws {
        cancelBag = CancelBag()
        
    }
    
    override func tearDown() {
        cancelBag = nil
    }
    
    func test_asURLRequest_정상적인속성일때_정상적인URLRequest반환() {
        let target: URLRequestTargetType = MockRequest(
            url: baseURL,
            path: path,
            method: method,
            headers: headers,
            task: .requestPlain,
            isWithInterceptor: true
        )
        let expectation = XCTestExpectation(description: "정상적인 바디일때 성공")
        
        target.asURLRequest()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure \(completion)")
                }
            }, receiveValue: { request in
                XCTAssertEqual(request.url?.absoluteString, "\(self.baseURL)")
                XCTAssertEqual(request.httpMethod, self.method.rawValue)
                XCTAssertEqual(request.allHTTPHeaderFields, self.headers)
                expectation.fulfill()
            })
            .store(in: cancelBag)
    }
    
    func test_asURLRequest_url이비어있을때_invalidURL에러반환() {
        let target: URLRequestTargetType = MockRequest(
            url: "",
            path: path,
            method: method,
            headers: headers,
            task: .requestPlain,
            isWithInterceptor: true
        )
        let expectation = XCTestExpectation(description: "fail")
        
        
        target.asURLRequest()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .invalidURL("" , .emptyurlString))
                    expectation.fulfill()
                }
            }, receiveValue: { request in
                XCTFail("Expected failure, but got success")
            })
            .store(in: cancelBag)
    }
    
    func test_asURLRequest_잘못된프로토콜일때_invalidProtocol에러반환() {
        let invalidProtocolURL: [String] = [
            "www.example.com",
            "htp://example.com"
        ]
        
        for url in invalidProtocolURL {
            let target: URLRequestTargetType = MockRequest(
                url: url,
                path: path,
                method: method,
                headers: headers,
                task: .requestPlain,
                isWithInterceptor: true
            )
            let expectation = XCTestExpectation(description: "fail")
            
            target.asURLRequest()
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTAssertEqual(error, .invalidURL(url, .invalidProtocol))
                        expectation.fulfill()
                    }
                }, receiveValue: { request in
                    XCTFail("Expected failure, but got success")
                })
                .store(in: cancelBag)
        }
    }
    
    func test_asURLRequest_잘못된포트번호일때_invalidPort에러반환() {
        
        let target: URLRequestTargetType = MockRequest(
            url: "https://example.com:99999",
            path: path,
            method: method,
            headers: headers,
            task: .requestPlain,
            isWithInterceptor: true
        )
        let expectation = XCTestExpectation(description: "fail")
        
        target.asURLRequest()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .invalidURL("https://example.com:99999", .invalidPort))
                    expectation.fulfill()
                }
            }, receiveValue: { request in
                XCTFail("Expected failure, but got success")
            })
            .store(in: cancelBag)
    }
    
    func test_asURLRequest_경로에공백이포함되어있을때_invalidPath에러반환() {
        let invalidPathURL: [String] = [
            "http://example.com/path|with|pipes",     // 유효하지 않은 특수 문자 포함 (|)
            "http://example.com/path with spaces",    // 유효하지 않은 공백 포함
            "http://example.com//double/slash",       // 중복 슬래시 포함
            "http://example.com/path#section",        // 유효하지 않은 특수 문자 (#)
        ]
        
        for url in invalidPathURL {
            let target: URLRequestTargetType = MockRequest(
                url: url,
                path: path,
                method: method,
                headers: headers,
                task: .requestPlain,
                isWithInterceptor: true
            )
            let expectation = XCTestExpectation(description: "fail")
            
            target.asURLRequest()
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTAssertEqual(error, .invalidURL(url, .invalidPath))
                        expectation.fulfill()
                    }
                }, receiveValue: { request in
                    XCTFail("Expected failure, but got success")
                })
                .store(in: cancelBag)
        }
    }
    
//    func test_asURLRequest_경로에사용될수없는문자가포함되어있을때_invalidCharacters에러반환() {
//        let invalidCharactersURL: [String] = [
//            "https://example.com/first|second",
//            "https://example.com/{first|second}",
//        ]
//        
//        for url in invalidCharactersURL {
//            let target: URLRequestTargetType = MockRequest(
//                url: url,
//                path: path,
//                method: method,
//                headers: headers,
//                task: .requestPlain,
//                isWithInterceptor: true
//            )
//            let expectation = XCTestExpectation(description: "fail")
//            
//            target.asURLRequest()
//                .sink(receiveCompletion: { completion in
//                    if case .failure(let error) = completion {
//                        XCTAssertEqual(error, .invalidURL(url, .invalidCharacters))
//                        expectation.fulfill()
//                    }
//                }, receiveValue: { request in
//                    XCTFail("Expected failure, but got success \(url)")
//                })
//                .store(in: cancelBag)
//        }
//    }
    
    func test_asURLRequest_유효하지않은쿼리파라미터가주어질때_invalidQueryParameter에러반환() {
        let invalidQueryParameterURL: [String] = [
            "https://example.com/api?keyvalue", // '='가 빠진 쿼리 파라미터
            "https://example.com/api?key=value&&another=value" // 쿼리 구분자 '&&'가 잘못됨
        ]
        
        for url in invalidQueryParameterURL {
            let target: URLRequestTargetType = MockRequest(
                url: url,
                path: path,
                method: method,
                headers: headers,
                task: .requestPlain,
                isWithInterceptor: true
            )
            let expectation = XCTestExpectation(description: "fail")
            
            target.asURLRequest()
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTAssertEqual(error, .invalidURL(url, .invalidQueryParameter))
                        expectation.fulfill()
                    }
                }, receiveValue: { request in
                    XCTFail("Expected failure, but got success \(url)")
                })
                .store(in: cancelBag)
        }
    }
}
