//
//  GetUserDataResponseDTO.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/14/24.
//

import Foundation

struct GetUserDataResponseDTO: Codable {
    let name: String
    let point: Int
    
    enum CodingKeys: CodingKey {
        case name
        case point
    }
}
