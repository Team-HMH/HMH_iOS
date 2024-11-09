//
//  RequestValidatorMockData.swift
//  Networks
//
//  Created by 류희재 on 11/10/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Networks

public struct RequestValidatorMockData {
    static public let validRequestData: (parameters: Parameters, url: URL) = (
        parameters: [
            "username": "류희재",
            "age": 25
        ],
        url: URL(string: "https://example.com")!
    )
    
    static public let nilRequestData: (parameters: Parameters?, url: URL?) = (
        parameters: nil,
        url: nil
    )
    
    static public let nilParameters: (parameters: Parameters?, url: URL) = (
        parameters: nil,
        url: URL(string: "https://example.com")!
    )
    
    static public let nilRequestURL: (parameters: Parameters?, url: URL?) = (
        parameters: [
            "username": "john_doe",
            "age": 30
        ],
        url: nil
    )
    
    static public let emptyRequestData: (parameters: Parameters, url: URL) = (
        parameters: [:],
        url: URL(string: "https://example.com")!
    )
    
    static public let validRequestDataWithOtherStructure: (parameters: Parameters, url: URL) = (
        parameters: [
            "id": 123,
            "status": "active"
        ],
        url: URL(string: "https://example.com/status")!
    )
    
    static public let validRequestDataWithSpecialChars: (parameters: Parameters, url: URL) = (
        parameters: [
            "query": "price > 100",
            "sort": "desc"
        ],
        url: URL(string: "https://example.com/search")!
    )
    
    static public let complexRequestData: (parameters: Parameters, url: URL) = (
        parameters: [
            "user": ["name": "Alice", "email": "alice@example.com"],
            "preferences": ["theme": "dark"]
        ],
        url: URL(string: "https://example.com/user")!
    )
}

