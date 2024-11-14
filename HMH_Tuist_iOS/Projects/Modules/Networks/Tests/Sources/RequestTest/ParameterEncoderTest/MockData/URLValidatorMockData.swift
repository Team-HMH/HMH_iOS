//
//  URLValidatorMockData.swift
//  NetworksTests
//
//  Created by 류희재 on 11/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Networks

struct URLValidatorMockData {
    let validURLData: [String] = [
    ]
    
    static let invalidURLData: [String] = invalidProtocolURL + invalidPortURL + invalidPathURL + invalidQueryURL
    
    static let urlTargetTypeMockData: [(url: String, path: String?, expectedURL: String?, error: HMHNetworkError.RequestError?)] = [
            (url: "http://example.com", path: "validPath", expectedURL: "http://example.com/validPath", error: nil),
            (url: "https://example.com", path: "api/v1", expectedURL: "https://example.com/api/v1", error: nil),
            (url: "", path: nil, expectedURL: nil, error: .invalidURL("", .emptyurlString)),
            (url: "www.example.com", path: nil, expectedURL: nil, error: .invalidURL("www.example.com", .invalidProtocol)),
            (url: "htp://example.com", path: nil, expectedURL: nil, error: .invalidURL("htp://example.com", .invalidProtocol)),
            (url: "https://example.com:99999", path: nil, expectedURL: nil, error: .invalidURL("https://example.com:99999", .invalidPort)),
            (url: "http://example.com", path: "path|with|pipes", expectedURL: nil, error: .invalidURL("http://example.com/path|with|pipes", .invalidPath)),
            (url: "http://example.com", path: "path with spaces", expectedURL: nil, error: .invalidURL("http://example.com/path with spaces", .invalidPath)),
            (url: "http://example.com", path: "/double/slash", expectedURL: nil, error: .invalidURL("http://example.com//double/slash", .invalidPath)),
            (url: "http://example.com", path: "path#section", expectedURL: nil, error: .invalidURL("http://example.com/path#section", .invalidPath)),
            (url: "http://example.com", path: "api?keyvalue", expectedURL: nil, error: .invalidURL("http://example.com/api?keyvalue", .invalidQueryParameter)),
            (url: "http://example.com", path: "api?key=value&&another=value", expectedURL: nil, error: .invalidURL("http://example.com/api?key=value&&another=value", .invalidQueryParameter))
        ]
}

extension URLValidatorMockData {
    static let invalidProtocolURL = [
        "ftp://example.com",
        "example.com",
        "www.example.com",
        "file://example.com"
    ]
    
    static let invalidPathURL = [
        "http://example.com/path|with|pipes",     // 유효하지 않은 특수 문자 포함 (|)
        "http://example.com/path with spaces",    // 유효하지 않은 공백 포함
        "http://example.com//double/slash",       // 중복 슬래시 포함
        "http://example.com/path%section",        // 유효하지 않은 특수 문자 (%)
        "http://example.com/path<section",        // 유효하지 않은 특수 문자 (<)
        "http://example.com/path>section",        // 유효하지 않은 특수 문자 (?)
        "http://example.com/path{section",        // 유효하지 않은 특수 문자 ({)
        "http://example.com/path}section",        // 유효하지 않은 특수 문자 (})
        "http://example.com/path\\section", // 유효하지 않은 특수 문자 (\\)
        "http://example.com/path#section", // 유효하지 않은 특수 문자 (#)
    ]
    
    static let invalidQueryURL = [
        "http://example.com/path?param1&param2=value",
        "http://example.com/path?param1=value&&param2=value"
    ]
    
    static let invalidPortURL = [
        "http://example.com:70000",
        "http://example.com:7002340",
        "http://example.com:234002340"
    ]
}
