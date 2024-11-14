//
//  TestEncodingHandler.swift
//  NetworksTests
//
//  Created by 류희재 on 11/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import XCTest

struct EncodingValidationHandler {
    static func checkValidHTTPBody(expectation: XCTestExpectation, validRequest: URLRequest, expectedParameter: Encodable) {
        do {
            let validJSON = try JSONSerialization.jsonObject(with: validRequest.httpBody!, options: []) as? [String: Any]
            
            let expectedData = try JSONEncoder().encode(expectedParameter)
            let expectedJSON = try JSONSerialization.jsonObject(with: expectedData, options: []) as? [String: Any]
            
            XCTAssertEqual(validJSON as NSDictionary?, expectedJSON as NSDictionary?, "파라미터가 예상 결과와 일치하지 않습니다.")
        } catch {
            XCTFail("JSON 처리 중 오류 발생: \(error)")
        }
    }
    
    static func checkValidQuaryItem(expectation: XCTestExpectation, validRequest: URLRequest, expectedQueryItems: [URLQueryItem]) {
        guard let url = validRequest.url,
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            XCTFail("Invalid URL or missing query parameters")
            return
        }
        
        let sortedQueryItems = queryItems.sorted(by: { $0.name < $1.name })
        let sortedExpectedQueryItems = expectedQueryItems.sorted(by: { $0.name < $1.name })
        
        XCTAssertEqual(sortedQueryItems, sortedExpectedQueryItems)
    }
}
