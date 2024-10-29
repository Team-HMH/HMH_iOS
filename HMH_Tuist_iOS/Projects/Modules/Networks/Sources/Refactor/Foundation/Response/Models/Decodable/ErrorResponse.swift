//
//  ErrorResponse.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

struct ErrorResponse: Decodable {
    var status: Int
    var message: String
    
    enum CodingKeys: CodingKey {
        case statusCode
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = (try? container.decode(Int.self, forKey: .statusCode)) ?? 500
        self.message = (try? container.decode(String.self, forKey: .message)) ?? ""
    }
}

