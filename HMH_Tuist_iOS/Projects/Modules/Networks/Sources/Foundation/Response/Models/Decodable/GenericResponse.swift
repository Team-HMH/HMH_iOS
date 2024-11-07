//
//  GenericResponse.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

struct GenericResponse<T: Decodable>: Decodable {
    var statusCode: Int
    var message: String
    var data: T?
    
    enum CodingKeys: CodingKey {
        case statusCode
        case message
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.statusCode = (try? container.decode(Int.self, forKey: .statusCode)) ?? 500
        self.message = (try? container.decode(String.self, forKey: .message)) ?? ""
        self.data = try container.decodeIfPresent(T.self, forKey: .data)
    }
}
