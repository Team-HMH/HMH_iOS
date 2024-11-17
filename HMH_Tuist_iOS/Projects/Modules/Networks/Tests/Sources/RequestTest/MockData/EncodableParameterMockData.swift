//
//  RequestValidatorMockData.swift
//  Networks
//
//  Created by 류희재 on 11/10/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

// RequestValidatorMockData.swift
// Networks
//
// Created by 류희재 on 11/10/24.
// Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Networks

// MARK: - Encodable Parameter Mock Data

struct EncodableParameterMockData {
    static let validEncodableParameter: Encodable = ["name": "John", "age": "25"]
    static let nilParameters: Encodable? = nil
}

// MARK: - Mock Data Aggregation

extension EncodableParameterMockData {
    struct NonEncodable {
        var name: String
        var age: Int
    }
    
    static let nonEncodableParameter: [String: Any?] = [
        "user": NonEncodable(name: "John", age: 30),
    ]
}

extension EncodableParameterMockData {
    static let validParameters: [Encodable] = [
        ["key1": "value1", "key2": "value2"],
        ["specialChars": "!@#$%^&*()"],
        ["space": "a value with spaces"],
        ["korean": "한글"],
        ["integer": 123, "float": 45.67],
        ["isTrue": true, "isFalse": false],
        ["empty": ""],
        ["Key": "UpperCase", "key": "LowerCase"]
    ]
}
