//
//  HomeChallengeResponseDTO.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/16/24.
//

import Foundation

struct HomeChallengeResponseDTO: Codable {
    let status: String
    let goalTime: Int
    let apps: [Apps]
}
