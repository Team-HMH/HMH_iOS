import Foundation
import Networks

public struct ParameterValidatorMockData {
    static public let validParameter: Parameters = [
            "username": "hellohidi",
            "age": 25
        ]
        
        static public let nilParameters: Parameters? = nil
        static public let emptyParameters: Parameters = [:]
    
    static public let validParameters: [(parameters: Parameters, expectedQueryItems: [URLQueryItem])] = [
        (simpleKeyValue, [URLQueryItem(name: "key1", value: "value1"), URLQueryItem(name: "key2", value: "value2")]),
        (specialCharacters, [URLQueryItem(name: "symbol", value: "!@#$%^&*()")]),
        (parametersWithSpaces, [URLQueryItem(name: "space", value: "a value with spaces")]),
        (multiLanguageCharacters, [URLQueryItem(name: "korean", value: "한글")]),
        (numericParameters, [URLQueryItem(name: "integer", value: "123"), URLQueryItem(name: "float", value: "45.67")]),
        (booleanValues, [URLQueryItem(name: "isTrue", value: "true"), URLQueryItem(name: "isFalse", value: "false")]),
        (emptyStrings, [URLQueryItem(name: "empty", value: "")]),
        (caseSensitiveKeys, [URLQueryItem(name: "Key", value: "UpperCase"), URLQueryItem(name: "key", value: "LowerCase")]),
        (jsonStringParameter, [URLQueryItem(name: "json", value: "{\"name\":\"test\",\"age\":30}")])
    ]
    
    // 각 파라미터 케이스
    static public let simpleKeyValue: Parameters = [
        "key1": "value1",
        "key2": "value2"
    ]
    
    static public let specialCharacters: Parameters = [
        "symbol": "!@#$%^&*()"
    ]
    
    static public let parametersWithSpaces: Parameters = [
        "space": "a value with spaces"
    ]
    
    static public let multiLanguageCharacters: Parameters = [
        "korean": "한글"
    ]
    
    static public let numericParameters: Parameters = [
        "integer": 123,
        "float": 45.67
    ]
    
    static public let booleanValues: Parameters = [
        "isTrue": true,
        "isFalse": false
    ]
    
    static public let emptyStrings: Parameters = [
        "empty": ""
    ]
    
    static public let caseSensitiveKeys: Parameters = [
        "Key": "UpperCase",
        "key": "LowerCase"
    ]
    
    static public let jsonStringParameter: Parameters = [
        "json": "{\"name\":\"test\",\"age\":30}"
    ]
}
