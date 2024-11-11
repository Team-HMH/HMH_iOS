//
//  RequestValidatorMockData.swift
//  Networks
//
//  Created by 류희재 on 11/10/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Networks

struct EncodableParameterMockData {
    static let mockURL = URL(string: "https://example.com")!
    
    static public let validEncodableData: (parameters: Encodable, url: URL) =
        (parameters: SimpleData(name: "John"), url: mockURL)
//    
//    ,
//    (parameters: OptionalData(name: nil),url: mockURL),
//    (parameters: UserData(name: "John", address: Address(street: "", city: "")),url: mockURL),
//    (parameters: ShoppingCart(items: []),url: mockURL),
//    (parameters: NestedArrayData(tags: [], items: [["item1"], []]),url: mockURL),
//    (parameters: SpecialCharacterData(url: "https://example.com/query?key1=value1&key2=value&"),url: mockURL),
//    (parameters: InvalidData(data: Data([0xFF, 0xFF])),url: mockURL)
//    
//]
    
    static public let nilRequestData: (parameters: Encodable?, url: URL?) = (
        parameters: nil,
        url: nil
    )
    
    static public let nilParameters: (parameters: Encodable?, url: URL?) = (
        parameters: nil,
        url: mockURL
    )
    
    static public let nilRequestURL: (parameters: Encodable?, url: URL?) = (
        parameters: SimpleData(name: "John"),
        url: nil
    )
}


struct SimpleData: Encodable {
    let name: String
}

struct OptionalData: Encodable {
    let name: String?
}

struct SpecialCharacterData: Encodable {
    let url: String
}

struct Address: Encodable {
    let street: String
    let city: String
}

struct UserData: Encodable {
    let name: String
    let address: Address
}

struct Item: Encodable {
    let id: Int
    let name: String
}

struct ShoppingCart: Encodable {
    let items: [Item]
}

struct NestedArrayData: Encodable {
    let tags: [String]
    let items: [[String]]
}

struct InvalidData: Encodable {
    let data: Data
}
