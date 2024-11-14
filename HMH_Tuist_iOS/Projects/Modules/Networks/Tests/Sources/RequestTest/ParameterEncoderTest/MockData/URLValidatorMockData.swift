//
//  URLValidatorMockData.swift
//  NetworksTests
//
//  Created by 류희재 on 11/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

struct URLValidatorMockData {
    let validURLData: [String] = [
    ]
    
    static let invalidURLData: [String] = invalidProtocolURL + invalidPortURL + invalidPathURL + invalidQueryURL
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
