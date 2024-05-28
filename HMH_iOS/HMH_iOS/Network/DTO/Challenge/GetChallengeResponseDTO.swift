//
//  getChallengeResponseDTO.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/16/24.
//

import Foundation

struct GetChallengeResponseDTO: Codable {
    let period: Int
    let statuses: [String]
    let todayIndex: Int
    let startDate: String
    let goalTime: Int
    let apps: [Apps]
}
