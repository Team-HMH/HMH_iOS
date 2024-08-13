//
//  BaseEntity.swift
//  MyPageFeatureInterface
//
//  Created by 류희재 on 8/13/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct BaseEntity<T: Decodable>: Decodable {
    public let success: Bool
    public let message: String
    public let data: T?
    
    enum CodingKeys: String, CodingKey {
        case success, message, data
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decode(Bool.self, forKey: .success)
        message = try values.decode(String.self, forKey: .message)
        data = try? values.decodeIfPresent(T.self, forKey: .data)
    }
}
