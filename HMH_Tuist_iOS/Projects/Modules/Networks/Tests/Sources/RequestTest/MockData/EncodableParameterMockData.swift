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

// MARK: Valid Encodable Data
struct SimpleData: Codable {
    let name: String?
}

struct EncodableParameterMockData {
    static let mockURL = URL(string: "https://example.com")!
    
    

    
    static let nilParameters: Encodable? = nil
    static let emptyParameters: Encodable = SimpleData(name: nil)
}

// MARK: - Invalid Data for Encoding

// 구조체들을 별도의 클래스로 정의
struct InvalidEncodingData {

    // 1. Encodable을 준수하지 않는 데이터
    struct NonEncodable {
        var name: String
        var age: Int
    }

    // 2. 순환 참조가 있는 구조체
    class Parent: Encodable {
        var name: String
        var child: Child?
        
        init(name: String) {
            self.name = name
        }
    }

    class Child: Encodable {
        var name: String
        var parent: Parent?
        
        init(name: String) {
            self.name = name
        }
    }

    // 3. 날짜 형식을 잘못된 형식으로 사용하는 경우
    static let invalidDateFormat: Encodable = [
        "date": Date()  // 만약 커스텀 날짜 포맷을 요구하는데 기본 Date 타입을 사용하면 실패할 수 있음
    ]

    // 4. 빈 배열 및 nil 값을 포함한 경우
    static let emptyArrayAndNilFields: [String: Any?] = [
        "emptyArray": [],
        "nullableField": nil  // nil 값이 포함된 경우
    ]

    // 5. 잘못된 특수문자 및 문자열 인코딩 실패
    static let invalidSpecialCharacters: Encodable = [
        "username": "john@doe!#",
        "password": "pass$word@123"  // 특수문자가 포함된 경우 인코딩이 실패할 수 있음
    ]

    // 6. 인코딩 불가능한 큰 데이터를 포함한 경우
    static let largeDataSet: Encodable = [
        "largeArray": Array(repeating: "longString", count: 1000000)  // 너무 큰 배열
    ]

    // 7. Data 타입의 값이 포함된 경우
    static let binaryData: Encodable = [
        "binaryData": Data()  // Data 타입은 기본적으로 JSON 인코딩이 불가능
    ]

    // 8. 옵셔널 타입의 값이 nil인 경우
    static let optionalNilValue: Encodable = [
        "optionalField": nil as String?  // 옵셔널이 nil인 경우
    ]

    // 10. JSON에 올바르지 않은 enum 값을 포함한 경우
    enum Status: String, Encodable {
        case active
        case inactive
    }

    static let invalidEnumValue: Encodable = [
        "status": Status(rawValue: "unknown")  // 올바르지 않은 rawValue 값을 가진 enum
    ]
}

// MARK: - Mock Data Aggregation

extension EncodableParameterMockData {
    // 1. Valid Data for Encodable
    static let validEncodableParameter: Encodable = SimpleData(name: "John")
    
    static let invalidParameterList: [Any] = [
//        invalidDateFormatParameter,
//        emptyArrayAndNilFieldsParameter,
//        invalidSpecialCharactersParameter,
//        largeDataSetParameter,
//        binaryDataInParameters,
//        optionalNilValueParameter,
//        invalidNumberFormatParameter,
        invalidEnumValueParameter
    ]
    
    static let nonEncodableParameter: [String: Any?] = [
        "user": InvalidEncodingData.NonEncodable(name: "John", age: 30),
        
    ]

    static let circularReferenceParameter: Parameters = [
        "parent": InvalidEncodingData.Parent(name: "John"),
        "child": InvalidEncodingData.Child(name: "Doe")
    ]
    static let invalidDateFormatParameter = InvalidEncodingData.invalidDateFormat
    static let emptyArrayAndNilFieldsParameter = InvalidEncodingData.emptyArrayAndNilFields
    static let invalidSpecialCharactersParameter = InvalidEncodingData.invalidSpecialCharacters
    static let largeDataSetParameter = InvalidEncodingData.largeDataSet
    static let binaryDataInParameters = InvalidEncodingData.binaryData
    static let optionalNilValueParameter = InvalidEncodingData.optionalNilValue
    static let invalidEnumValueParameter = InvalidEncodingData.invalidEnumValue
}
