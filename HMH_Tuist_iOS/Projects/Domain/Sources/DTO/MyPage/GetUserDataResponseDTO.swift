//
//  GetUserDataResponseDTO.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/14/24.
//

import Foundation

public struct GetUserDataResponseDTO: Codable {
    public let name: String
    public  let point: Int
    
    enum CodingKeys: CodingKey {
        case name
        case point
    }
}
