//
//  URLValidatorTest.swift
//  NetworksTests
//
//  Created by 류희재 on 11/12/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Core
import Networks

class URLValidatorTest: XCTestCase {
    
    var cancelBag: CancelBag!
    
    override func setUpWithError() throws {
        cancelBag = CancelBag()
    }
    
    override func tearDown() {
        cancelBag = nil
    }
    
    func test_빈url이주어질때_emptyurlString에러반환() {
        let result = URLValidator.validateURL("")
        XCTAssertEqual(result, .failure(.emptyurlString))
    }
    
    func test_잘못된프로토콜이주어질때_invalidProtocol에러반환() {
        for url in URLValidatorMockData.invalidProtocolURL {
            let result = URLValidator.validateURL(url)
            XCTAssertEqual(result, .failure(.invalidProtocol))
        }
    }
    
    func test_잘못된포트번호가주어질때_invalidPort에러반환() {
        for url in URLValidatorMockData.invalidPortURL {
            let result = URLValidator.validateURL(url)
            XCTAssertEqual(result, .failure(.invalidPort))
        }
        
        func test_잘못된경로가주어질때_invalidPath에러반환() {
            for url in URLValidatorMockData.invalidPathURL {
                let result = URLValidator.validateURL(url)
                XCTAssertEqual(result, .failure(.invalidPath))
            }
        }
        
        func test_잘못된쿼리파라미터가주어질때_invalidQueryParameter에러반환() {
            for url in URLValidatorMockData.invalidQueryURL {
                let result = URLValidator.validateURL(url)
                XCTAssertEqual(result, .failure(.invalidQueryParameter))
            }
        }
        
        func test_정상적인URL이주어질때_정상적인반환() {
            let result = URLValidator.validateURL("http://example.com/path?param1=value&param2=value")
            switch result {
            case .success(let url):
                XCTAssertEqual(url.absoluteString, "http://example.com/path?param1=value&param2=value")
            case .failure(let error):
                XCTFail("Expected valid URL but got failure \(error)")
            }
        }
    }
}
