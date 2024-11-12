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
    static let validEncodableParameter: Encodable = SimpleData(name: "John", age: 25)
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
    static let validtestData: [(Encodable, String)] = [
        (SimpleData(name: "John", age: 30), "SimpleData"),
        (OptionalStringData(name: "John"), "OptionalStringData"),
        (ArrayData(items: ["Item1", "Item2", "Item3"]), "ArrayData"),
        (ObjectArrayData(items: [
            Item(id: 1, description: "Item 1"),
            Item(id: 2, description: "Item 2")
        ]), "ObjectArrayData"),
        (EnumData(status: .active), "EnumData"),
        (DateData(date: Date()), "DateData"),
        (EmptyDictionaryData(), "EmptyDictionaryData"),
        (DataData(data: Data()), "DataData"),
        (SimpleStructureData(title: "Title", description: "Description"), "SimpleStructureData"),
        (ParentData(name: "Parent", child: ChildData(name: "Child")), "ParentData")
    ]
}



// 1. 간단한 문자열과 정수 값
struct SimpleData: Codable {
    let name: String
    let age: Int
}

// 2. 옵셔널 문자열
struct OptionalStringData: Codable {
    let name: String?
}

// 3. 배열
struct ArrayData: Codable {
    let items: [String]
}

// 4. 객체 배열
struct Item: Codable {
    let id: Int
    let description: String
}

struct ObjectArrayData: Codable {
    let items: [Item]
}

// 5. Enum 타입
enum Status: String, Codable {
    case active
    case inactive
}

struct EnumData: Codable {
    let status: Status
}

// 6. 날짜 타입
struct DateData: Codable {
    let date: Date
}

// 7. 빈 딕셔너리
struct EmptyDictionaryData: Codable {}

// 8. Data 타입 (빈 Data)
struct DataData: Codable {
    let data: Data
}

// 9. 간단한 구조체
struct SimpleStructureData: Codable {
    let title: String
    let description: String
}

// 10. 중첩된 구조체
struct ParentData: Codable {
    let name: String
    let child: ChildData
}

struct ChildData: Codable {
    let name: String
}
