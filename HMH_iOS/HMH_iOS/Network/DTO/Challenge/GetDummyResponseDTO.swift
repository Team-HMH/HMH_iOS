//
//  GetDummyResponseDTO.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/19/24.
//

import Foundation

struct GetDummyResponseDTO: Codable {
    let apps: [Application]
}

struct Application: Codable {
    let appName: String
    let appImageURL: String
    let goalTime, usageTime: Int
    
    enum CodingKeys: String, CodingKey {
        case appName
        case appImageURL = "appImageUrl"
        case goalTime, usageTime
    }
}
