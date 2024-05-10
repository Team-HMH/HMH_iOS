//
//  GetHomeChallengeResponseDTO.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/18/24.
//

import Foundation

struct GetHomeChallengeResponseDTO: Codable {
    let status: String
    let goalTime: Int
    let apps: [Apps]
}
