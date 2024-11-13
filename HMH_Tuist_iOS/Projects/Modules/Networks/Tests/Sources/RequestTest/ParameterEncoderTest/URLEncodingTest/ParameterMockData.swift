//
//  ParameterMockData.swift
//  Networks
//
//  Created by 류희재 on 11/11/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Networks

public struct ParameterValidatorMockData {
    static public let validParameters: [Parameters] = [
        validParameter,
        specialCharacters,
        largeNumbers,
        unicodeCharacters,
        booleanValues,
        arrayData,
        nestedData,
        emptyStrings,
        nestedEmptyData
    ]
    
    static public let validParameter: Parameters = [
            "username": "hellohidi",
            "age": 25
        ]
    
    static public let nilParameters: Parameters? = nil
    static public let emptyParameters: Parameters = [:]
    
    static public let specialCharacters: Parameters = [
        "query": "name=hello&value=world",
        "symbol": "!@#$%^&*()_+|"
    ]
    
    static public let largeNumbers: Parameters = [
        "count": 123456789,
        "maxValue": Int.max,
        "minValue": Int.min
    ]
    
    static public let unicodeCharacters: Parameters = [
        "greeting": "안녕하세요",
        "emoji": "🙂🚀"
    ]
    
    static public let booleanValues: Parameters = [
        "isActive": true,
        "isAdmin": false
    ]
    
    static public let arrayData: Parameters = [
        "tags": ["swift", "ios", "xcode"],
        "values": [1, 2, 3, 4]
    ]
    
    static public let nestedData: Parameters = [
        "user": ["name": "John", "age": 30],
        "location": ["city": "Seoul", "country": "Korea"]
    ]
    
    static public let nullValues: Parameters = [
        "nickname": NSNull(),
        "score": NSNull()
    ]
    
    static public let emptyStrings: Parameters = [
        "title": "",
        "description": ""
    ]
    
    static public let nestedEmptyData: Parameters = [
        "info": ["name": "", "age": 0],
        "address": ["city": "", "country": ""]
    ]
}

